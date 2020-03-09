const express = require('express');
const router = express.Router();

const mysql = require('mysql');
const dbconfig = require('../db/db');
var conn = mysql.createPool(dbconfig.mysql);

const multer = require('multer');   // 文件上传

const util = require('../util/util');


/*----------------------------------------------------------------------------------------------------------------*/


/* GET home page. */
router.get('/', function (req, res, next) {
    res.render('index', {title: 'Express'});
});


/*----------------------------------------------------------------------------------------------------------------*/


//校验用户登录
router.post('/api/login', function (req, res) {
    let studentNo = req.body.studentNo;
    let studentPassword = req.body.studentPassword;
    let sqlStr = "select * from t_student_info where student_no = ?;";
    let params = [];
    params.push(studentNo);
    params.push(studentPassword);
    conn.query(sqlStr, params, function (error, result) {
        if (error) {
            res.json({error_code: 1, message: "查询用户失败"});
        } else {
            result = JSON.parse(JSON.stringify(result));
            if (result[0]) {
                if (result[0].student_password === studentPassword) {
                    req.session.studentId = result[0].student_id;
                    res.cookie('student_id', result[0].student_id);
                    res.cookie('lectures_num', result[0].lectures_num);
                    res.json({success_code: 200});
                } else {
                    res.json({error_code: 1, message: '密码错误'});
                }
            } else {
                res.json({error: 1, message: '用户不存在'});
            }
        }
    });
});


// 忘记密码时获取用户信息
router.get('/api/getProtectionInfoByStudentNo', function (req, res) {
    let studentNo = req.query.studentNo;
    let sqlStr = 'SELECT * FROM t_student_info s, t_student_protection p WHERE s.student_id = p.protection_student_id AND s.student_no = ? LIMIT 1 ;';
    conn.query(sqlStr, [studentNo], (error, result, field) => {
        if (error) {
            res.json({error_code: 1, message: '查询密保失败'});
        } else {
            result = JSON.parse(JSON.stringify(result));
            if (result[0]) {
                res.json({success_code: 200, data: result[0]});
            } else {
                res.json({error: 1, message: '密保不存在'});
            }
        }
    })
});


/*----------------------------------------------------------------------------------------------------------------*/


// 获取用户信息
router.get('/api/getStudentInfo', function (req, res) {
    let studentId = req.query.studentId;
    let sqlStr = 'SELECT * FROM t_student_info WHERE student_id = ? LIMIT 1 ;';
    conn.query(sqlStr, [studentId], (error, result, field) => {
        if (error) {
            res.json({error_code: 1, message: '查询用户失败'});
        } else {
            result = JSON.parse(JSON.stringify(result));
            if (result[0]) {
                res.json({success_code: 200, data: result[0]});
            } else {
                res.json({error: 1, message: '用户不存在'});
            }
        }
    })
});


/*----------------------------------------------------------------------------------------------------------------*/


// 图片地址
var imageAdress = './public/images/avatar/user/';


//将图片放到服务器
var storage = multer.diskStorage({
    // 如果你提供的 destination 是一个函数，你需要负责创建文件夹
    destination: imageAdress,
    // 给上传文件重命名，获取添加后缀名
    filename: function (req, file, cb) {
        cb(null, new Date().getTime() + '.jpg');
    }
});


var upload = multer({
    storage: storage
});


router.post('/api/upLoadImg', upload.any(), function (req, res) {
    res.json({success_code: 200, data: req.files});
    console.log(req.files);
});


//更新头像信息
router.post('/api/updateAvatar', function (req, res) {
    let {
        new_avatar,
        student_id,
    } = req.body;
    let sqlStr = 'UPDATE t_student_info SET avatar = ? WHERE student_id = ? ;';
    conn.query(sqlStr, [new_avatar, student_id], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            res.json({success_code: 200})
        }
    });
});


/*----------------------------------------------------------------------------------------------------------------*/


// 查询密保信息
router.get('/api/getProtectionInfo', function (req, res) {
    let student_id = req.query.student_id;
    let sqlStr = 'SELECT * FROM t_student_info s, t_student_protection p WHERE s.student_id = p.protection_student_id AND s.student_id = ? LIMIT 1 ;';
    conn.query(sqlStr, [student_id], (error, result, field) => {
        if (error) {
            res.json({error_code: 1, message: '查询密保失败'});
        } else {
            result = JSON.parse(JSON.stringify(result));
            if (result[0]) {
                res.json({success_code: 200, data: result[0]});
            } else {
                res.json({error: 1, message: '密保不存在'});
            }
        }
    })
});


//添加密保
router.post('/api/addProtection', function (req, res) {
    let {
        protection_student_id,
        question_1,
        question_2,
        question_3,
        answer_1,
        answer_2,
        answer_3
    } = req.body;
    let sqlStr = 'SELECT * FROM t_student_info s, t_student_protection p WHERE s.student_id = p.protection_student_id AND s.student_id = ? LIMIT 1 ;';
    conn.query(sqlStr, [protection_student_id], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            result = JSON.parse(JSON.stringify(result));
            if (result[0]) {
                res.json({error_code: 1, message: '密保只能设置一次！'});
            } else {
                let sqlStr = 'INSERT INTO t_student_protection(protection_student_id,question_1,question_2,question_3,answer_1,answer_2,answer_3) VALUES(?,?,?,?,?,?,?);';
                conn.query(sqlStr, [protection_student_id, question_1, question_2, question_3, answer_1, answer_2, answer_3], (error, result, field) => {
                    if (error) {
                        console.log(error);
                    } else {
                        res.json({success_code: 200});
                    }
                })
            }
        }
    });
});


//更新密码
router.post('/api/updatePassword', function (req, res) {
    let {
        new_password,
        student_id,
    } = req.body;
    let sqlStr = 'UPDATE t_student_info SET student_password = ? WHERE student_id = ? ;';
    conn.query(sqlStr, [new_password, student_id], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            res.json({success_code: 200})
        }
    });
});


/*----------------------------------------------------------------------------------------------------------------*/


//获取当前页讲座
router.get('/api/getCurrentPageLecture', function (req, res) {
    // 第几页，一页几条，搜索内容
    let {
        currentPage, pageSize, input
    } = req.query;
    // 查询行数开始索引
    let start = Number((currentPage - 1) * pageSize);
    // 开始后几行
    pageSize = Number(pageSize);
    // 查询结果数量
    let total;

    // 优先，根据输入搜索
    // 其次，如果输入框没有内容，那么搜索的是全部
    let sqlStr = 'SELECT l.*, c.* FROM t_lecture_info l, t_classroom_info c WHERE l.classroom_id = c.classroom_id AND (l.title LIKE ? OR l.teacher LIKE ?) ORDER BY l.application_deadline DESC';
    conn.query(sqlStr, ["%" + input + "%", "%" + input + "%"], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            result = JSON.parse(JSON.stringify(result));
            total = result.length;
        }
    });

    // 分页的查询
    sqlStr = 'SELECT l.*, c.* FROM t_lecture_info l, t_classroom_info c WHERE l.classroom_id = c.classroom_id AND (l.title LIKE ? OR l.teacher LIKE ?) ORDER BY l.application_deadline DESC LIMIT ?,?;';
    conn.query(sqlStr, ["%" + input + "%", "%" + input + "%", start, pageSize], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            result = JSON.parse(JSON.stringify(result));
            res.json({success_code: 200, data: result, total: total});
        }
    })
});


// 获取课室信息
router.get('/api/getClassroomInfo', function (req, res) {
    let classroomId = req.query.classroomId;
    let sqlStr = 'SELECT * FROM t_classroom_info WHERE classroom_id = ? ;';
    conn.query(sqlStr, [classroomId], (error, result, field) => {
        if (error) {
            res.json({error_code: 1, message: '查询课室失败'});
        } else {
            result = JSON.parse(JSON.stringify(result));
            if (result[0]) {
                res.json({success_code: 200, data: result[0]});
            } else {
                res.json({error: 1, message: '课室不存在'});
            }
        }
    })
});


/*----------------------------------------------------------------------------------------------------------------*/


// 查询讲座对应教室行列范围
router.get('/api/getLectureClassroom', function (req, res) {
    let lecture_id = req.query.lecture_id;
    let sqlStr = 'SELECT * FROM t_lecture_info l, t_classroom_info c WHERE l.lecture_id = ? AND l.classroom_id = c.classroom_id LIMIT 1 ;';
    conn.query(sqlStr, [lecture_id], (error, result, field) => {
        if (error) {
            res.json({error_code: 1, message: '查询教室失败'});
        } else {
            result = JSON.parse(JSON.stringify(result));
            if (result[0]) {
                res.json({success_code: 200, data: result[0]});
            } else {
                res.json({error: 1, message: '教室不存在'});
            }
        }
    })
});


// 查已选座位
router.get('/api/getLectureClassroomIsSelected', function (req, res) {
    let lecture_id = req.query.lecture_id;
    let sqlStr = 'SELECT * FROM r_lecture_seat WHERE lecture_id = ? AND (seat_type = 2 OR is_selected = 1);';
    conn.query(sqlStr, [lecture_id], (error, result, field) => {
        if (error) {
            res.json({error_code: 1, message: '查询教室已选座位失败'});
        } else {
            result = JSON.parse(JSON.stringify(result));
            if (result[0]) {
                res.json({success_code: 200, data: result});
            } else {
                res.json({error: 1, message: '教室已选座位不存在'});
            }
        }
    })
});


// 通过讲座id、座位x、y，查询座位id
router.post('/api/findSeatId', function (req, res) {
    let {
        lecture_id,
        seat_x,
        seat_y
    } = req.body;
    let sqlStr = 'SELECT lecture_seat_id FROM r_lecture_seat WHERE lecture_id = ? AND (seat_x = ? AND seat_y = ?) LIMIT 1 ;';
    conn.query(sqlStr, [lecture_id, seat_x, seat_y], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            res.json({success_code: 200, data: result});
        }
    });
});


// 通过学生id（好友id）、讲座id，查询该学生是否选了该讲座
router.post('/api/findLectureByStudentId', function (req, res) {
    let {
        student_id,
        lecture_id,
    } = req.body;
    let sqlStr = 'SELECT * FROM r_student_operation WHERE student_id = ? and lecture_id = ? and is_delete = 0';
    conn.query(sqlStr, [student_id, lecture_id], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            if (result[0]) {
                res.json({status_code: 1, message: 'student_id ' + student_id + ' 已预约该讲座！'});
            } else {
                res.json({status_code: 200});
            }
        }
    });
});


/*----------------------------------------------------------------------------------------------------------------*/


/*预约与删除预约，需要修改4个表，写了四个请求，有机会再改*/


// 预约
/*1、改r_lectrue_seat表*/
router.post('/api/selectSeatUpdateSeat', function (req, res) {
    let {
        lecture_id,
        seat_x,
        seat_y
    } = req.body;
    let sqlStr = 'SELECT * FROM r_lecture_seat WHERE lecture_id = ? and seat_x = ? and seat_y = ?';
    conn.query(sqlStr, [lecture_id, seat_x, seat_y], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            result = JSON.parse(JSON.stringify(result));
            if (!result[0]) {
                res.json({error_code: 1, message: '该座位未设置类型，不可选！'});
            } else {
                let sqlStr = 'UPDATE r_lecture_seat SET is_selected = 1 WHERE lecture_id = ? AND seat_type = 1 AND (seat_x = ? AND seat_y = ?);';
                conn.query(sqlStr, [lecture_id, seat_x, seat_y], (error, result, field) => {
                    if (error) {
                        console.log(error);
                    } else {
                        res.json({success_code: 200})
                    }
                });
            }
        }
    });
});


// 删除预约
/*1、改r_lectrue_seat表*/
router.post('/api/deleteOrderUpdateSeat', function (req, res) {
    let {
        lecture_id,
        seat_x,
        seat_y
    } = req.body;
    let sqlStr = 'UPDATE r_lecture_seat SET is_selected = 0 WHERE lecture_id = ?  AND is_selected = 1 AND (seat_x = ? AND seat_y = ?);';
    conn.query(sqlStr, [lecture_id, seat_x, seat_y], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            res.json({success_code: 200})
        }
    });
});


// 预约
/*2、改t_lectrue_info表*/
router.post('/api/selectSeatUpdateLecture', function (req, res) {
    let {
        lecture_id
    } = req.body;
    let sqlStr = 'UPDATE t_lecture_info SET seats_selected_num = (seats_selected_num + 1) WHERE lecture_id = ?;';
    conn.query(sqlStr, [lecture_id], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            res.json({success_code: 200})
        }
    });
});


// 删除预约
/*2、改t_lectrue_info表*/
router.post('/api/deleteOrderUpdateLecture', function (req, res) {
    let {
        lecture_id
    } = req.body;
    let sqlStr = 'UPDATE t_lecture_info SET seats_selected_num = (seats_selected_num - 1) WHERE lecture_id = ?;';
    conn.query(sqlStr, [lecture_id], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            res.json({success_code: 200})
        }
    });
});


// 预约
/*3、改r_student_operation表*/
router.post('/api/selectSeatUpdateOperation', function (req, res) {
    let {
        student_id,
        lecture_id,
        seat_id,
    } = req.body;
    let sqlStr = 'SELECT * FROM r_student_operation WHERE student_id = ? and lecture_id = ?';
    conn.query(sqlStr, [student_id, lecture_id], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            result = JSON.parse(JSON.stringify(result));
            if (result[0]) {
                if (result[0].is_delete == 0) {
                    res.json({error_code: 1, message: 'student_id ' + student_id + ' 已预约该讲座！'});
                } else {
                    let sqlStr = 'UPDATE r_student_operation SET is_delete = 0 WHERE student_id = ? and lecture_id = ?;';
                    conn.query(sqlStr, [student_id, lecture_id], (error, result, field) => {
                        if (error) {
                            console.log(error);
                        } else {
                            res.json({success_code: 200})
                        }
                    });
                }
            } else {
                let ticket_code = parseInt(Date.parse(new Date()).toString().substr(4, 6));
                let now = new Date();
                let sqlStr = 'INSERT INTO r_student_operation(student_id,lecture_id,seat_id,ticket_code,operate_time,is_delete) VALUES(?,?,?,?,?,0);';
                conn.query(sqlStr, [student_id, lecture_id, seat_id, ticket_code, now], (error, result, field) => {
                    if (error) {
                        console.log(error);
                    } else {
                        res.json({success_code: 200});
                    }
                })
            }
        }
    });
});


// 删除预约
/*3、改r_student_operation表*/
router.post('/api/deleteOrderUpdateOperation', function (req, res) {
    let {
        student_id,
        lecture_id,
    } = req.body;
    let sqlStr = 'UPDATE r_student_operation SET is_delete = 1 WHERE student_id = ? and lecture_id = ?;';
    conn.query(sqlStr, [student_id, lecture_id], (error, result, field) => {
        if (error) {
            res.json({error_code: 1, message: '该讲座早已删除！'});
        } else {
            res.json({success_code: 200});
        }
    });
});


// 预约
/*4、改r_operation_record表*/
// operation_type操作类型，0选择1删除；object操作对象，0用户1管理员
router.post('/api/selectSeatUpdateRecord', function (req, res) {
    let {
        student_id,
        lecture_id,
    } = req.body;
    let now = new Date();
    let sqlStr = 'INSERT INTO r_operation_record(student_id,lecture_id,operation_time,operation_type,object) VALUES(?,?,?,0,0);';
    conn.query(sqlStr, [student_id, lecture_id, now], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            res.json({success_code: 200});
        }
    });
});


// 删除预约
/*4、改r_operation_record表*/
// operation_type操作类型，0选择1删除；object操作对象，0用户1管理员
router.post('/api/deleteOrderUpdateRecord', function (req, res) {
    let {
        student_id,
        lecture_id,
    } = req.body;
    let now = new Date();
    let sqlStr = 'INSERT INTO r_operation_record(student_id,lecture_id,operation_time,operation_type,object) VALUES(?,?,?,1,0);';
    conn.query(sqlStr, [student_id, lecture_id, now], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            res.json({success_code: 200});
        }
    });
});


/*----------------------------------------------------------------------------------------------------------------*/


// 获取当前页预约
router.get('/api/getCurrentPageOrder', function (req, res) {
    // 第几页，一页几条，搜索内容
    let {
        student_id, currentPage, pageSize, input
    } = req.query;
    // 查询行数开始索引
    let start = Number((currentPage - 1) * pageSize);
    // 开始后几行
    pageSize = Number(pageSize);
    // 查询结果数量
    let total;

    // 优先，根据输入搜索
    // 其次，如果输入框没有内容，那么搜索的是全部
    let sqlStr = 'SELECT * FROM t_lecture_info l, t_classroom_info c, r_student_operation o, r_lecture_seat s WHERE o.student_id = ? AND l.classroom_id = c.classroom_id AND l.lecture_id = o.lecture_id AND o.seat_id = s.lecture_seat_id AND o.is_delete != 1 AND (l.title LIKE ? OR l.teacher LIKE ?) ORDER BY l.application_deadline DESC ;';
    conn.query(sqlStr, [student_id, "%" + input + "%", "%" + input + "%"], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            result = JSON.parse(JSON.stringify(result));
            total = result.length;
        }
    });

    // 分页的查询
    sqlStr = 'SELECT * FROM t_lecture_info l, t_classroom_info c, r_student_operation o, r_lecture_seat s WHERE o.student_id = ? AND l.classroom_id = c.classroom_id AND l.lecture_id = o.lecture_id AND o.seat_id = s.lecture_seat_id AND o.is_delete != 1 AND (l.title LIKE ? OR l.teacher LIKE ?) ORDER BY l.application_deadline DESC LIMIT ?,? ;';
    conn.query(sqlStr, [student_id, "%" + input + "%", "%" + input + "%", start, pageSize], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            result = JSON.parse(JSON.stringify(result));
            res.json({success_code: 200, data: result, total: total});
        }
    })
});


// 判断学生的讲座状态
// 状态（待审核[完成表没有讲座id]、合格[完成表有讲座id和学生id]、不合格[完成表有讲座id，没有学生id]）
router.post('/api/readStudentLectureStatus', function (req, res) {
    let {
        student_id,
        lecture_id
    } = req.body;
    let theStatus;
    let sqlStr = 'SELECT * FROM r_student_accomplishment WHERE lecture_id = ? LIMIT 1 ;';
    conn.query(sqlStr, [lecture_id], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            result = JSON.parse(JSON.stringify(result));
            if (!result[0]) {
                theStatus = "待审核";
                res.json({success_code: 200, theStatus: theStatus});
            } else {
                let sqlStr = 'SELECT * FROM r_student_accomplishment WHERE lecture_id = ? AND student_id = ? LIMIT 1 ;';
                conn.query(sqlStr, [lecture_id, student_id], (error, result, field) => {
                    if (error) {
                        console.log(error);
                    } else {
                        result = JSON.parse(JSON.stringify(result));
                        if (result[0]) {
                            theStatus = "合格";
                            res.json({success_code: 200, theStatus: theStatus});
                        } else {
                            theStatus = "不合格";
                            res.json({success_code: 200, theStatus: theStatus});
                        }
                    }
                });
            }
        }
    });
});


/*----------------------------------------------------------------------------------------------------------------*/


//获取当前页收藏
router.get('/api/getCurrentPageCollection', function (req, res) {
    // 第几页，一页几条，搜索内容
    let {
        student_id, currentPage, pageSize, input
    } = req.query;
    // 查询行数开始索引
    let start = Number((currentPage - 1) * pageSize);
    // 开始后几行
    pageSize = Number(pageSize);
    // 查询结果数量
    let total;

    // 优先，根据输入搜索
    // 其次，如果输入框没有内容，那么搜索的是全部
    let sqlStr = 'SELECT s.*, l.*, c.* FROM t_student_info s, t_lecture_info l, r_student_collection sc, t_classroom_info c WHERE s.student_id = ? AND s.student_id = sc.student_id AND l.lecture_id = sc.lecture_id AND c.classroom_id = l.classroom_id AND (l.title LIKE ? OR l.teacher LIKE ?) ORDER BY l.application_deadline DESC;';
    conn.query(sqlStr, [student_id, "%" + input + "%", "%" + input + "%"], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            result = JSON.parse(JSON.stringify(result));
            total = result.length;
        }
    });

    // 分页的查询
    sqlStr = 'SELECT s.*, l.*, c.* FROM t_student_info s, t_lecture_info l, r_student_collection sc, t_classroom_info c WHERE s.student_id = ? AND s.student_id = sc.student_id AND l.lecture_id = sc.lecture_id AND c.classroom_id = l.classroom_id AND (l.title LIKE ? OR l.teacher LIKE ?) ORDER BY l.application_deadline DESC LIMIT ?,?;';
    conn.query(sqlStr, [student_id, "%" + input + "%", "%" + input + "%", start, pageSize], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            result = JSON.parse(JSON.stringify(result));
            res.json({success_code: 200, data: result, total: total});
        }
    })
});


//添加收藏
router.post('/api/addCollection', function (req, res) {
    let {
        student_id,
        lecture_id
    } = req.body;
    let sqlStr = 'SELECT * FROM r_student_collection WHERE student_id = ? and lecture_id = ? ;';
    conn.query(sqlStr, [student_id, lecture_id], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            result = JSON.parse(JSON.stringify(result));
            if (result[0]) {
                res.json({error_code: 1, message: '该讲座已收藏！'});
            } else {
                let sqlStr = 'INSERT INTO r_student_collection(student_id,lecture_id) VALUES(?,?);';
                conn.query(sqlStr, [student_id, lecture_id], (error, result, field) => {
                    if (error) {
                        console.log(error);
                    } else {
                        res.json({success_code: 200});
                    }
                })
            }
        }
    });
});


//删除收藏
router.post('/api/deleteCollection', function (req, res) {
    let {
        student_id,
        lecture_id
    } = req.body;
    let sqlStr = 'DELETE FROM r_student_collection WHERE student_id = ? AND lecture_id = ?';
    conn.query(sqlStr, [student_id, lecture_id], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            res.json({success_code: 200});
        }
    })
});


/*----------------------------------------------------------------------------------------------------------------*/


//获取当前页好友
router.post('/api/getCurrentPageRelationship', function (req, res) {
    // 第几页，一页几条，搜索内容
    let {
        main_student_id, currentPage, pageSize, input
    } = req.body;
    // 查询行数开始索引
    let start = Number((currentPage - 1) * pageSize);
    // 开始后几行
    pageSize = Number(pageSize);
    // 查询结果数量
    let total;

    // 优先，根据输入搜索
    // 其次，如果输入框没有内容，那么搜索的是全部
    let sqlStr = 'SELECT r.*, s2.* FROM t_student_info s1, r_student_relationship r, t_student_info s2 WHERE s1.student_id = ? AND s1.student_id = r.main_student_id AND s2.student_id = r.fellow_student_id AND s2.student_name LIKE ? ORDER BY r.fellow_student_id;';
    conn.query(sqlStr, [main_student_id, "%" + input + "%"], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            result = JSON.parse(JSON.stringify(result));
            total = result.length;
        }
    });

    // 分页的查询
    sqlStr = 'SELECT r.*, s2.* FROM t_student_info s1, r_student_relationship r, t_student_info s2 WHERE s1.student_id = ? AND s1.student_id = r.main_student_id AND s2.student_id = r.fellow_student_id AND s2.student_name LIKE ? ORDER BY r.fellow_student_id LIMIT ?,?;';
    conn.query(sqlStr, [main_student_id, "%" + input + "%", start, pageSize], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            result = JSON.parse(JSON.stringify(result));
            res.json({success_code: 200, data: result, total: total});
        }
    })
});


//添加好友
router.post('/api/addRelationship', function (req, res) {
    let {
        main_student_id,
        fellow_student_no,
        fellow_student_friend_code
    } = req.body;
    let sqlStr = 'SELECT r.*, s2.* FROM t_student_info s1, r_student_relationship r, t_student_info s2 WHERE s1.student_id = ? AND s1.student_id = r.main_student_id AND s2.student_id = r.fellow_student_id AND s2.student_no = ? AND s2.friend_code = ?;';
    conn.query(sqlStr, [main_student_id, fellow_student_no, fellow_student_friend_code], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            result = JSON.parse(JSON.stringify(result));
            if (result[0]) {
                res.json({error_code: 1, message: '该好友已添加！'});
            } else {
                let sqlStr = 'SELECT student_id fellow_student_id FROM t_student_info WHERE student_no = ? AND friend_code = ?;';
                conn.query(sqlStr, [fellow_student_no, fellow_student_friend_code], (error, result, field) => {
                    if (error) {
                        console.log(error);
                    } else {
                        result = JSON.parse(JSON.stringify(result));
                        if (!result[0]) {
                            res.json({error_code: 1, message: '好友ID或好友码错误！'});
                        } else {
                            let fellow_student_id = result[0].fellow_student_id;
                            let sqlStr = 'INSERT INTO r_student_relationship(main_student_id,fellow_student_id) VALUES(?,?);';
                            conn.query(sqlStr, [main_student_id, fellow_student_id], (error, result, field) => {
                                if (error) {
                                    console.log(error);
                                } else {
                                    sqlStr = 'INSERT INTO r_student_relationship(main_student_id,fellow_student_id) VALUES(?,?);';
                                    conn.query(sqlStr, [fellow_student_id, main_student_id], (error, result, field) => {
                                        if (error) {
                                            console.log(error);
                                        } else {
                                            res.json({success_code: 200});
                                        }
                                    });
                                }
                            })
                        }
                    }
                })
            }
        }
    });
});


//删除好友
router.post('/api/deleteRelationship', function (req, res) {
    let {
        main_student_id,
        fellow_student_id
    } = req.body;
    let sqlStr = 'DELETE FROM r_student_relationship WHERE main_student_id = ? AND fellow_student_id = ?;';
    conn.query(sqlStr, [main_student_id, fellow_student_id], (error, result, field) => {
        if (error) {
            console.log(error);
        } else {
            sqlStr = 'DELETE FROM r_student_relationship WHERE main_student_id = ? AND fellow_student_id = ?;';
            conn.query(sqlStr, [fellow_student_id, main_student_id], (error, result, field) => {
                if (error) {
                    console.log(error);
                } else {
                    res.json({success_code: 200});
                }
            });
        }
    });
});


/*----------------------------------------------------------------------------------------------------------------*/


module.exports = router;

