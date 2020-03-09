const express = require('express');
const router = express.Router();
const mysql = require('mysql');
const dbconfig = require('../db/db');
const util = require('../util/util');
const multer = require('multer');
var conn = mysql.createPool(dbconfig.mysql);
var bodyParser = require('body-parser');
var urlencodedParser = bodyParser.urlencoded({extended:false})

// 用户API
let user = {};

/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('index', { title: 'Express' });
});



//校验教师登录
router.post('/api/admin/login',urlencodedParser,function (req, res) {
    var userNo = req.body.userNo;
    var password = req.body.password;
    var sqlStr = "select * from t_administrator_info where administrator_no = ? ;";
    var params = new Array();
    params.push(userNo);
    conn.query(sqlStr,params,function (error, result) {
       if (error){
           res.json({error_code:1,message:"查询用户失败"});
       } else {
           result = JSON.parse(JSON.stringify(result));
           if (result[0]){
               if (result[0].administrator_password === password){
                   req.session.adminId = result[0].administrator_no;
                   res.cookie('adminId',result[0].administrator_no);
                   res.json({success_code:200});
               }else {
                   res.json({error_code:1,message:'密码错误'});
               }
           }else {
               res.json({error:1,message:'用户不存在'});
           }
       }
    });
});


//获取管理员信息
router.get('/api/admin/getAdminInfo',function(req,res){
    let adminId = req.query.adminId;
    let sqlStr = 'SELECT * FROM t_administrator_info WHERE administrator_no = ?;';
    conn.query(sqlStr,[adminId],(error,result,field)=>{
        if (error){
            res.json({error_code:1,message:'查询用户失败'});
        } else{
            result = JSON.parse(JSON.stringify(result));
            if (result[0]){
                res.json({success_code:200,data:result[0]});
            } else{
                res.json({error:1,message:'用户不存在'});
            }
        }
    })
});


//获取所有学生信息
router.get('/api/admin/getAllStudentInfos',function (req, res) {
    var selectSql = 'select * from t_student_info';
    conn.query(selectSql,function (error, result) {
        if (error) throw error;
        console.log('............................')
        console.log(result);
        res.json(result);
    });
});


//分页获取所有学生信息
router.get('/api/admin/getCurrentPageStudents',function(req,res){
    let {
        currentPage, pageSize
    } = req.query;
    let start = Number((currentPage-1)*pageSize);
    pageSize = Number(pageSize);
    let sqlStr = 'SELECT * FROM t_student_info;';
    let total;
    conn.query(sqlStr,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            total = result.length;
        }
    });
    sqlStr = 'SELECT * FROM t_student_info LIMIT ?,?;';
    conn.query(sqlStr,[start,pageSize],(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            res.json({success_code:200,data:result,total:total});
        }
    });
});

//分页获取所有学生信息
router.get('/api/admin/getStudentByStudentNo',function(req,res){
    let {
        currentPage, pageSize, student_no
    } = req.query;
    let start = Number((currentPage-1)*pageSize);
    pageSize = Number(pageSize);
    let sqlStr = 'SELECT * FROM t_student_info where student_no like ? ;';
    let total;
    conn.query(sqlStr,['%'+student_no+'%'],(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            total = result.length;
        }
    });
    sqlStr = 'SELECT * FROM t_student_info where student_no like ? LIMIT ?,?;';
    conn.query(sqlStr,['%'+student_no+'%',start,pageSize],(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            res.json({success_code:200,data:result,total:total});
        }
    });
});

//删除学生信息,先把学生选择的座位释放,再删除学生
router.post('/api/admin/deleteStudentInfo',function(req,res){
    let {
        studentId
    } = req.body;
    if (studentId){
        let sqlStr = 'SELECT * from r_student_operation WHERE student_id = ?';
        conn.query(sqlStr,[studentId],(error,result,field)=>{
            if (error){
                console.log(error);
            } else{
                result = JSON.parse(JSON.stringify(result));
                // console.log(result);
                if (result){
                    result.forEach((value)=>{
                        value.seat_id = JSON.parse(value.seat_id);
                        // console.log(value.seat_id);
                        sqlStr = 'UPDATE r_lecture_seat SET is_selected = 0 WHERE lecture_seat_id = ?;';
                        conn.query(sqlStr,[value.seat_id],(error,result,field)=>{
                            if (error){
                                console.log(error);
                            }
                        })
                    })
                }
                sqlStr = 'DELETE FROM t_student_info WHERE student_id =?';
                conn.query(sqlStr,[studentId],(error,result,field)=>{
                    if (error){
                        console.log(error);
                    } else {
                        res.json({success_code:200});
                    }
                })
            }
        })
    }
});


var userImageSrc = './public/images/avatar/user/';
//将图片放到服务器
var storageUserImg = multer.diskStorage({
    // 如果你提供的 destination 是一个函数，你需要负责创建文件夹
    destination: userImageSrc,
    // //给上传文件重命名，获取添加后缀名
    filename: function (req, file, cb) {
        cb(null, new Date().getTime()+'.jpg');
    }
});
var upload = multer({
    storage: storageUserImg
});
router.post('/api/admin/upLoadImg',upload.any(),function (req,res) {
    res.json({success_code:200,data:req.files});
    console.log(req.files);
});


//更新学生信息
router.post('/api/admin/updateStudentInfo',function(req,res){
    let {
        student_id,
        student_no,
        student_name,
        gender,
        grade,
        faculty,
        major,
        lectures_num,
        id_no,
        student_password,
        avatar
    } = req.body;
    if (student_id){
        let sqlStr = 'SELECT * from t_student_info WHERE student_id = ? ;';
        conn.query(sqlStr,[student_id],(error,result,field)=>{
            if (error){
                res.json({error_code:1,message:'学生不存在'});
            } else {
                //更新数据库
                let sqlStr = 'UPDATE t_student_info SET student_no = ?,student_name = ?,gender = ?,grade = ? ,faculty = ?,major = ?,lectures_num = ?, id_no = ?, student_password = ?, avatar = ? WHERE student_id = ?;';
                conn.query(sqlStr, [student_no,student_name,gender,grade,faculty,major,lectures_num,id_no,student_password,avatar,student_id], (error, result, field) => {
                    if (error) {
                        res.json({error_code: 1, message: '更新学生信息失败'});
                        console.log(error);
                    } else {
                        res.json({success_code: 200})
                    }
                });
            }
        })
    }
});

//添加学生信息
router.post('/api/admin/addStudentInfo',function(req,res){
    let {
        student_no,
        student_name,
        gender,
        grade,
        faculty,
        major,
        lectures_num,
        id_no,
        student_password,
        avatar
    } = req.body;
    if (!avatar){
        avatar = '/images/avatar/bnuz.png'
    }
    let sqlStr = 'SELECT * from t_student_info WHERE student_no = ? ;';
    conn.query(sqlStr,[student_no],(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            if (result[0]){
                res.json({error_code:1,message:'此学生已存在！'});
            } else{
                let friend_code = util.randomFriendCode(8,16);
                sqlStr = 'INSERT INTO t_student_info(student_no,student_name,gender,grade,faculty,major,lectures_num,id_no,student_password,avatar,friend_code) VALUES(?,?,?,?,?,?,?,?,?,?,?);';
                conn.query(sqlStr,[student_no,student_name,gender,grade,faculty,major,lectures_num,id_no,student_password,avatar,friend_code],(error,result,field)=>{
                    if (error){
                        console.log(error);
                    } else{
                        res.json({success_code:200});
                    }
                })
            }
        }
    });
});

//获取所有楼栋
router.get('/api/admin/getClassroomBuilding',function(req,res){
    let sqlStr = 'select distinct building from t_classroom_info';
    conn.query(sqlStr,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            res.json({success_code:200,data:result});
        }
    });
});

//通过楼栋获取此楼栋的所有教室
router.get('/api/admin/getClassroomByBuilding',function(req,res){
    let {
        building
    } = req.query;
    let sqlStr = 'select * from t_classroom_info where building = ? order by classroom_id; ';
    conn.query(sqlStr,[building],(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            res.json({success_code:200,data:result});
        }
    });
});

//通过楼栋和位置获取此教室
router.get('/api/admin/getClassroomByBuildingAndLocation',function(req,res){
    let {
        building,location
    } = req.query;
    let sqlStr = 'select * from t_classroom_info where building = ? and location = ? order by classroom_id; ';
    conn.query(sqlStr,[building,location],(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            res.json({success_code:200,data:result});
        }
    });
});

//通过教室id获取教室
router.get('/api/admin/getClassroomById',function(req,res){
    let {
        classroom_id
    } = req.query;
    let sqlStr = 'select * from t_classroom_info where classroom_id = ?; ';
    conn.query(sqlStr,[classroom_id],(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            res.json({success_code:200,data:result});
        }
    });
});


//获取当前页教室
router.get('/api/admin/getCurrentPageClassroom',function(req,res){
    let {
        currentPage, pageSize,input
    } = req.query;
    let start = Number((currentPage-1)*pageSize);
    pageSize = Number(pageSize);
    let sqlStr;
    let params;
    if (input=="") {
        sqlStr = 'SELECT * FROM t_classroom_info order by classroom_id ;';
        params = [];
    }
    else{
        if (input.length <= 3){
            sqlStr = 'SELECT * FROM t_classroom_info WHERE building LIKE ? order by classroom_id ;';
            params = ["%"+input+"%"];
        }
        else {
            sqlStr = 'SELECT * FROM t_classroom_info WHERE building LIKE ? and location LIKE ? order by classroom_id ;';
            params = ["%"+input.slice(0,3)+"%","%"+input.slice(3)+"%"];
        }
    }
    let total;
    conn.query(sqlStr,params,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            total = result.length;
        }
    });
    if ( input=="") {
        sqlStr = 'SELECT * FROM t_classroom_info ORDER BY classroom_id LIMIT ?,?;';
        params = [start,pageSize];
    }
    else {
        if (input.length <= 3){
            sqlStr = 'SELECT * FROM t_classroom_info WHERE building LIKE ? ORDER BY classroom_id LIMIT ?,?;';
            params = ["%"+input+"%",start,pageSize];
        }
        else{
            sqlStr = 'SELECT * FROM t_classroom_info WHERE building LIKE ? AND location LIKE ? ORDER BY classroom_id LIMIT ?,?;';
            params = ["%"+input.slice(0,3)+"%","%"+input.slice(3)+"%",start,pageSize];
        }
    }
    conn.query(sqlStr,params,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            res.json({success_code:200,data:result,total:total});
        }
    })
});


//更新教室信息
router.post('/api/admin/updateClassroomInfo',function(req,res){
    let {
        classroom_id,
        building,
        location,
        row_num,
        column_num,
        capacity
    } = req.body;
    if (classroom_id){
        let sqlStr = 'SELECT * from t_classroom_info WHERE classroom_id = ?;';
        conn.query(sqlStr,[classroom_id],(error,result,field)=>{
            if (error){
                console.log(error);
            } else{
                sqlStr = 'SELECT * FROM t_classroom_info WHERE building = ? AND location = ? ;';
                conn.query(sqlStr,[building,location],(error,result,field)=>{
                    if (error){
                        console.log(error);
                    } else{
                        result = JSON.parse(JSON.stringify(result));
                        if (result[0]){
                            let sqlStr = 'UPDATE t_classroom_info SET building = ?,location = ?,row_num = ?,column_num = ?,capacity = ? WHERE classroom_id = ?;';
                            conn.query(sqlStr,[building,location,row_num,column_num,capacity,classroom_id],(error,result,field)=>{
                                if (error){
                                    res.json({error_code:1,message:'更新教室信息失败'});
                                    console.log(error);
                                } else{
                                    res.json({success_code:200})
                                }
                            })
                        } else{
                            res.json({error_code:1,message:'更新教室信息失败'});
                        }
                    }
                });
            }
        })
    }
});

//添加教室信息
router.post('/api/admin/addClassroomInfo',function(req,res){
    let {
        building,
        location,
        row_num,
        column_num,
        capacity
    } = req.body;
    let sqlStr = 'SELECT * FROM t_classroom_info WHERE building = ? and location = ? ;';
    conn.query(sqlStr,[building,location],(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            if (result[0]){
                res.json({error_code:1,message:'此教室已存在！'});
            } else{
                sqlStr = 'INSERT INTO t_classroom_info(building,location,row_num,column_num,capacity) VALUES(?,?,?,?,?);';
                conn.query(sqlStr,[building,location,row_num,column_num,capacity],(error,result,field)=>{
                    if (error){
                        console.log(error);
                    } else{
                        res.json({success_code:200,id:result.insertId});
                    }
                })
            }
        }
    });
});


//删除教室信息
router.post('/api/admin/deleteClassroomInfo',function(req,res){
    let {
        classroom_id
    } = req.body;
    if (classroom_id){
        let sqlStr = 'DELETE FROM t_classroom_info WHERE classroom_id =?';
        conn.query(sqlStr,[classroom_id],(error,result,field)=>{
            if (error){
                console.log(error);
            } else {
                res.json({success_code:200});
            }
        })
    }
});


//联表查询讲座的全部信息，联t_lecture_info,t_classroom_info
router.get('/api/admin/getCurrentPageLecture',function (req, res) {
    let {
        currentPage, pageSize,input
    } = req.query;
    let start = Number((currentPage-1)*pageSize);
    pageSize = Number(pageSize);
    let sqlStr;
    let params;
    if (input=="") {
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info where t_classroom_info.classroom_id = t_lecture_info.classroom_id order by lecture_id;';
        params = [];
    }
    else{
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info where t_classroom_info.classroom_id = t_lecture_info.classroom_id and title like ? order by lecture_id;';
        params = ["%"+input+"%"];
    }
    let total;
    conn.query(sqlStr,params,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            total = result.length;
        }
    });
    if ( input=="") {
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info where t_classroom_info.classroom_id = t_lecture_info.classroom_id order by lecture_id LIMIT ?,? ;';
        params = [start,pageSize];
    }
    else {
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info where t_classroom_info.classroom_id = t_lecture_info.classroom_id and title like ? order by lecture_id LIMIT ?,? ;';
        params = ["%"+input+"%",start,pageSize];
    }
    conn.query(sqlStr,params,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            res.json({success_code:200,data:result,total:total});
        }
    })
});

//根据讲座id联表查询讲座的全部信息，联t_lecture_info,t_classroom_info
router.get('/api/admin/getLectureInfoById',function (req, res) {
    let {
        lecture_id
    } = req.query;
    let sqlStr;
    let params;
    sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info where t_classroom_info.classroom_id = t_lecture_info.classroom_id and t_lecture_info.lecture_id = ?;';
    params = [lecture_id];
    conn.query(sqlStr,params,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            res.json({success_code:200,data:result[0]});
        }
    })
});



var src = './public/images/avatar/admin/postImage/';
//将图片放到服务器
var storagePoster = multer.diskStorage({
    // 如果你提供的 destination 是一个函数，你需要负责创建文件夹
    destination: src,
    // //给上传文件重命名，获取添加后缀名
    filename: function (req, file, cb) {
        cb(null, new Date().getTime()+'.jpg');
    }
});
var uploadPoster = multer({
    storage: storagePoster
});
router.post('/api/admin/upLoadPosterImg',uploadPoster.any(),function (req,res) {
    res.json({success_code:200,data:req.files});
    console.log(req.files);
});

//添加讲座信息
router.post('/api/admin/addLectureInfo',function(req,res){
    let {
        title,
        teacher,
        introduction,
        image,
        classroom_id,
        start_time,
        end_time,
        total_seats_num,
        seats_selected_num,
        application_deadline
    } = req.body;
    if (!image){
        image = '/images/avatar/admin/postImage/bnuz.jpg'
    }
    let sqlStr = 'SELECT * FROM t_lecture_info WHERE teacher = ? and classroom_id = ? and start_time = ?;';
    conn.query(sqlStr,[teacher,classroom_id,start_time],(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            if (result[0]){
                res.json({error_code:1,message:'此教师在此时间已存在讲座！'});
            } else{
                sqlStr = 'INSERT INTO t_lecture_info(title,teacher,introduction,image,classroom_id,start_time,end_time,total_seats_num,seats_selected_num,application_deadline) VALUES(?,?,?,?,?,?,?,?,?,?);';
                conn.query(sqlStr,[title,teacher,introduction,image,classroom_id,start_time,end_time,total_seats_num,seats_selected_num,application_deadline],(error,result,field)=>{
                    if (error){
                        console.log(error);
                    } else{
                        res.json({success_code:200,lecture_id:result.insertId});
                    }
                })
            }
        }
    });
});

//删除讲座信息
router.post('/api/admin/deleteLectureInfo',function(req,res){
    let {
        lecture_id
    } = req.body;
    if (lecture_id){
        let sqlStr = 'DELETE FROM t_lecture_info WHERE lecture_id =?';
        conn.query(sqlStr,[lecture_id],(error,result,field)=>{
            if (error){
                console.log(error);
            } else {
                res.json({success_code:200});
            }
        })
    }
});

//更新讲座信息
router.post('/api/admin/updateLectureInfo',function(req,res){
    let {
        lecture_id,
        title,
        teacher,
        introduction,
        image,
        classroom_id,
        start_time,
        end_time,
        total_seats_num,
        seats_selected_num,
        application_deadline
    } = req.body;
    if (!image){
        image = '/images/avatar/admin/postImage/bnuz.jpg'
    }
    if (lecture_id){
        let sqlStr = 'SELECT * from t_lecture_info WHERE lecture_id = ?;';
        conn.query(sqlStr,[lecture_id],(error,result,field)=>{
            if (error){
                console.log(error);
            } else{
                let sqlStr = 'UPDATE t_lecture_info SET title = ?,teacher = ?,introduction = ?,image = ?, classroom_id = ?,start_time = ?, end_time = ?, total_seats_num = ?, seats_selected_num = ?, application_deadline = ? WHERE lecture_id = ?;';
                conn.query(sqlStr,[title,teacher,introduction,image,classroom_id,start_time,end_time,total_seats_num,seats_selected_num,application_deadline,lecture_id],(error,result,field)=>{
                    if (error){
                        res.json({error_code:1,message:'修改讲座信息失败'});
                        console.log(error);
                    } else{
                        res.json({success_code:200})
                    }
                })
            }
        })
    }
});

//添加讲座的座位信息
router.post('/api/admin/addLectureSeatInfo',function(req,res){
    let {
        lecture_id,
        seats_info,
    } = req.body;
    // console.log(seats_info);
    seats_info = JSON.stringify(seats_info);
    seats_info = JSON.parse(seats_info);
    let sqlStr,params;
    if (lecture_id){
        let sqlStr = 'SELECT * from r_lecture_seat WHERE lecture_id = ?;';
        conn.query(sqlStr,[lecture_id],(error,result,field)=> {
            if (error) {
                console.log(error);
            }
            else {
                result = JSON.parse(JSON.stringify(result));
                if (result[0]){
                    sqlStr = 'delete from r_lecture_seat where lecture_id = ?;';
                    conn.query(sqlStr,[lecture_id],(error,result,field)=>{
                        if (error){
                            console.log(error);
                        }
                        else {
                            params = [];
                            for (let i = 0; i < seats_info.length; i++) {
                                let value = [];
                                value.push(lecture_id);
                                value.push(seats_info[i].seat_type);
                                value.push(seats_info[i].x);
                                value.push(seats_info[i].y);
                                value.push(1);
                                value.push(0);
                                params.push(value);
                            }
                            sqlStr = 'insert into r_lecture_seat(lecture_id,seat_type,seat_x,seat_y,is_show,is_selected) values ? ';
                            conn.query(sqlStr,[params],(error,result,field)=>{
                                if (error){
                                    console.log(error);
                                    res.json({success_code:0});
                                } else {
                                    res.json({success_code:200});
                                }
                            })
                        }
                    })
                }
                else {
                    params = [];
                    for (let i = 0; i < seats_info.length; i++) {
                        let value = [];
                        value.push(lecture_id);
                        value.push(seats_info[i].seat_type);
                        value.push(seats_info[i].x);
                        value.push(seats_info[i].y);
                        value.push(1);
                        value.push(0);
                        params.push(value);
                    }
                    sqlStr = 'insert into r_lecture_seat(lecture_id,seat_type,seat_x,seat_y,is_show,is_selected) values ? ';
                    conn.query(sqlStr,[params],(error,result,field)=>{
                        if (error){
                            console.log(error);
                            res.json({success_code:0});
                        } else {
                            res.json({success_code:200});
                        }
                    })
                }
            }

        })
    }
});

//删除讲座的座位信息
router.post('/api/admin/deleteLectureSeatInfo',function(req,res){
    let {
        lecture_id,
    } = req.body;
    let sqlStr,params;
    if (lecture_id){
        let sqlStr = 'SELECT * from r_lecture_seat WHERE lecture_id = ?;';
        conn.query(sqlStr,[lecture_id],(error,result,field)=> {
            if (error) {
                console.log(error);
            }
            else {
                if (result[0]){
                    sqlStr = 'delete from r_lecture_seat where lecture_id = ?;';
                    conn.query(sqlStr,[lecture_id],(error,result,field)=>{
                        if (error){
                            console.log(error);
                        }
                        else {
                            res.json({success_code:200});
                        }
                    })
                }
            }

        })
    }
});


//联表查询讲座的学生的全部信息，联t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat
router.get('/api/admin/getCurrentPageLectureStudents',function (req, res) {
    let {
        lecture_id,currentPage, pageSize,input
    } = req.query;
    let start = Number((currentPage-1)*pageSize);
    pageSize = Number(pageSize);
    let sqlStr;
    let params;
    if (input=="") {
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat where t_classroom_info.classroom_id = t_lecture_info.classroom_id and t_lecture_info.lecture_id = r_student_operation.lecture_id and t_student_info.student_id = r_student_operation.student_id and r_student_operation.seat_id = r_lecture_seat.lecture_seat_id and is_delete = 0 and r_student_operation.lecture_id = ? order by operation_id;';
        params = [lecture_id];
    }
    else{
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat where t_classroom_info.classroom_id = t_lecture_info.classroom_id and t_lecture_info.lecture_id = r_student_operation.lecture_id and t_student_info.student_id = r_student_operation.student_id and r_student_operation.seat_id = r_lecture_seat.lecture_seat_id and is_delete = 0 and r_student_operation.lecture_id = ?  and t_student_info.student_no like ? order by operation_id;';
        params = [lecture_id,"%"+input+"%"];
    }
    let total;
    conn.query(sqlStr,params,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            total = result.length;
        }
    });
    if ( input=="") {
        console.log("aaa");
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat where t_classroom_info.classroom_id = t_lecture_info.classroom_id and t_lecture_info.lecture_id = r_student_operation.lecture_id and t_student_info.student_id = r_student_operation.student_id and r_student_operation.seat_id = r_lecture_seat.lecture_seat_id and is_delete = 0 and r_student_operation.lecture_id = ? order by operation_id LIMIT ?,? ;';
        // params = [lecture_id];
        params = [lecture_id,start,pageSize];

    }
    else {
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat where t_classroom_info.classroom_id = t_lecture_info.classroom_id and t_lecture_info.lecture_id = r_student_operation.lecture_id and t_student_info.student_id = r_student_operation.student_id and r_student_operation.seat_id = r_lecture_seat.lecture_seat_id and is_delete = 0 and r_student_operation.lecture_id = ?  and t_student_info.student_no like ? order by operation_id LIMIT ?,? ;';
        params = [lecture_id,"%"+input+"%",start,pageSize];
    }
    conn.query(sqlStr,params,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            console.log(result[0]);
            res.json({success_code:200,data:result,total:total});
        }
    })
});


//删除讲座的某个学生信息
router.post('/api/admin/deleteLectureStudentInfo',function(req,res){
    let {
        lecture_id,
        student_id,
        seat_id
    } = req.body;
    // console.log(lecture_id);
    // console.log(student_id);
    console.log(seat_id);
    let sqlStr,params;
    if (lecture_id){
        let sqlStr = 'SELECT * from r_student_operation WHERE lecture_id = ? and student_id = ?;';
        conn.query(sqlStr,[lecture_id,student_id],(error,result,field)=> {
            if (error) {
                console.log(error);
                res.json({success_code:0});
            }
            else {
                if (result[0]){
                    let time = new Date();
                    sqlStr = 'update r_student_operation set is_delete = 1, operate_time = ? where lecture_id = ? and student_id = ?;';
                    conn.query(sqlStr,[time,lecture_id,student_id],(error,result,field)=>{
                        if (error){
                            console.log(error);
                            res.json({success_code:0});
                        }
                        else {
                            sqlStr = 'insert into r_operation_record(student_id,lecture_id,operation_time,operation_type,object) values(?,?,?,?,?)';
                            conn.query(sqlStr,[student_id,lecture_id,time,0,1],(error,result,field)=>{
                               if (error){
                                   console.log(error);
                                   res.json({success_code:0});
                               }
                               else {
                                   sqlStr = 'update r_lecture_seat set is_selected = 0 where lecture_id = ? and lecture_seat_id = ?;';
                                   conn.query(sqlStr,[lecture_id,seat_id],(error,result,field)=>{
                                       if (error){
                                           console.log(error);
                                       }
                                       else {
                                           res.json({success_code:200});
                                       }
                                   })
                               }
                            });
                        }
                    })
                }
                else {
                    res.json({success_code:0});
                }
            }

        })
    }
});


//确认学生完成了此次讲座
router.post('/api/admin/confirmLectureStudentInfo',function(req,res){
    let {
        lecture_id,
        student_id
    } = req.body;
    console.log(lecture_id);
    console.log(student_id);
    let sqlStr,params;
    if (lecture_id){
        let sqlStr = 'SELECT * from r_student_operation WHERE lecture_id = ? and student_id = ? and is_delete = 0;';
        conn.query(sqlStr,[lecture_id,student_id],(error,result,field)=> {
            if (error) {
                console.log(error);
                res.json({success_code:0});
            }
            else {
                if (result[0]){
                    console.log("aaa");
                    let time = new Date();
                    sqlStr = 'insert into r_student_accomplishment(student_id,lecture_id,operate_time) values(?,?,?)';
                    conn.query(sqlStr,[student_id,lecture_id,time],(error,result,field)=>{
                        if (error){
                            console.log(error);
                            res.json({success_code:0});
                        }
                        else {
                            sqlStr = 'select distinct * from r_student_accomplishment where student_id = ?;';
                            conn.query(sqlStr,[student_id],(error,result,field)=>{
                               if(error) console.log(error);
                               else {
                                   if (result[0]){
                                       sqlStr = 'update t_student_info set lectures_num = ? where student_id = ?;';
                                       conn.query(sqlStr,[result.length,student_id],(error,result,field)=>{
                                           if (error) console.log(error);
                                           else{
                                               res.json({success_code:200});
                                           }
                                       });
                                   }
                               }
                            });
                        }
                    });
                }
                else {
                    res.json({success_code:0});
                }
            }
        })
    }
});

//确认全部学生完成了此次讲座
router.post('/api/admin/confirmAllLectureStudentInfo',function(req,res){
    let {
        lecture_id,
    } = req.body;
    console.log(lecture_id);
    let sqlStr,params;
    if (lecture_id){
        let sqlStr = 'SELECT * from r_student_operation WHERE lecture_id = ? and is_delete = 0;';
        conn.query(sqlStr,[lecture_id],(error,result,field)=> {
            if (error) {
                console.log(error);
                res.json({success_code:0});
            }
            else {
                if (result[0]){
                    let values = [];
                    for (let i = 0; i < result.length; i++) {
                        let temp = [];
                        temp.push(result[i].student_id);
                        temp.push(result[i].lecture_id);
                        temp.push(new Date());
                        values.push(temp);
                    }
                    sqlStr = 'insert into r_student_accomplishment(student_id,lecture_id,operate_time) values ?';
                    conn.query(sqlStr,[values],(error,result,field)=>{
                        if (error){
                            console.log(error);
                            res.json({success_code:0});
                        }
                        else {
                            for (let i = 0; i < values.length; i++) {
                                sqlStr = 'select distinct * from r_student_accomplishment where student_id = ?;';
                                conn.query(sqlStr,[values[i][0]],(error,result,field)=>{
                                    if(error) {
                                        console.log(error);
                                        res.json({success_code:0});
                                    }
                                    else {
                                        if (result[0]){
                                            sqlStr = 'update t_student_info set lectures_num = ? where student_id = ?;';
                                            conn.query(sqlStr,[result.length,values[i][0]],(error,result,field)=>{
                                                if (error) {
                                                    console.log(error);
                                                    res.json({success_code:0});
                                                }
                                            });
                                        }
                                    }
                                });
                            }
                            res.json({success_code:200});
                        }
                    });
                }
                else {
                    res.json({success_code:0});
                }
            }
        })
    }
});


//联表查询讲座已完成任务的学生的全部信息，联t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat,r_student_accomplishment
router.get('/api/admin/getCurrentPageLectureFinishedStudents',function (req, res) {
    let {
        lecture_id,currentPage, pageSize,input
    } = req.query;
    let start = Number((currentPage-1)*pageSize);
    pageSize = Number(pageSize);
    let sqlStr;
    let params;
    if (input=="") {
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat,r_student_accomplishment where t_classroom_info.classroom_id = t_lecture_info.classroom_id and t_lecture_info.lecture_id = r_student_operation.lecture_id and t_student_info.student_id = r_student_operation.student_id and r_student_operation.seat_id = r_lecture_seat.lecture_seat_id and is_delete = 0 and r_student_accomplishment.lecture_id = r_student_operation.lecture_id and r_student_accomplishment.student_id = r_student_operation.student_id and r_student_operation.lecture_id = ? order by operation_id;';
        params = [lecture_id];
    }
    else{
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat,r_student_accomplishment where t_classroom_info.classroom_id = t_lecture_info.classroom_id and t_lecture_info.lecture_id = r_student_operation.lecture_id and t_student_info.student_id = r_student_operation.student_id and r_student_operation.seat_id = r_lecture_seat.lecture_seat_id and is_delete = 0 and r_student_accomplishment.lecture_id = r_student_operation.lecture_id and r_student_accomplishment.student_id = r_student_operation.student_id and r_student_operation.lecture_id = ?  and t_student_info.student_no like ? order by operation_id;';
        params = [lecture_id,"%"+input+"%"];
    }
    let total;
    conn.query(sqlStr,params,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            total = result.length;
        }
    });
    if ( input=="") {
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat,r_student_accomplishment where t_classroom_info.classroom_id = t_lecture_info.classroom_id and t_lecture_info.lecture_id = r_student_operation.lecture_id and t_student_info.student_id = r_student_operation.student_id and r_student_operation.seat_id = r_lecture_seat.lecture_seat_id and is_delete = 0 and r_student_accomplishment.lecture_id = r_student_operation.lecture_id and r_student_accomplishment.student_id = r_student_operation.student_id and r_student_operation.lecture_id = ? order by operation_id LIMIT ?,? ;';
        // params = [lecture_id];
        params = [lecture_id,start,pageSize];

    }
    else {
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat,r_student_accomplishment where t_classroom_info.classroom_id = t_lecture_info.classroom_id and t_lecture_info.lecture_id = r_student_operation.lecture_id and t_student_info.student_id = r_student_operation.student_id and r_student_operation.seat_id = r_lecture_seat.lecture_seat_id and is_delete = 0 and r_student_accomplishment.lecture_id = r_student_operation.lecture_id and r_student_accomplishment.student_id = r_student_operation.student_id and r_student_operation.lecture_id = ?  and t_student_info.student_no like ? order by operation_id LIMIT ?,? ;';
        params = [lecture_id,"%"+input+"%",start,pageSize];
    }
    conn.query(sqlStr,params,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            // console.log(result[0]);
            res.json({success_code:200,data:result,total:total});
        }
    })
});


//联表查询讲座未完成任务的学生的全部信息，联t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat,r_student_accomplishment
router.get('/api/admin/getCurrentPageLectureNotFinishedStudents',function (req, res) {
    let {
        lecture_id,currentPage, pageSize,input
    } = req.query;
    let start = Number((currentPage-1)*pageSize);
    pageSize = Number(pageSize);
    let sqlStr;
    let params;
    if (input=="") {
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat where t_classroom_info.classroom_id = t_lecture_info.classroom_id and t_lecture_info.lecture_id = r_student_operation.lecture_id and t_student_info.student_id = r_student_operation.student_id and r_student_operation.seat_id = r_lecture_seat.lecture_seat_id and is_delete = 0 and r_student_operation.lecture_id = ? and r_student_operation.student_id not in (select student_id from r_student_accomplishment where lecture_id = ?) order by operation_id;';
        params = [lecture_id,lecture_id];
    }
    else{
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat where t_classroom_info.classroom_id = t_lecture_info.classroom_id and t_lecture_info.lecture_id = r_student_operation.lecture_id and t_student_info.student_id = r_student_operation.student_id and r_student_operation.seat_id = r_lecture_seat.lecture_seat_id and is_delete = 0 and r_student_operation.lecture_id = ? and r_student_operation.student_id not in (select student_id from r_student_accomplishment where lecture_id = ?) and t_student_info.student_no like ? order by operation_id;';
        params = [lecture_id,lecture_id,"%"+input+"%"];
    }
    let total;
    conn.query(sqlStr,params,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            total = result.length;
        }
    });
    if ( input=="") {
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat where t_classroom_info.classroom_id = t_lecture_info.classroom_id and t_lecture_info.lecture_id = r_student_operation.lecture_id and t_student_info.student_id = r_student_operation.student_id and r_student_operation.seat_id = r_lecture_seat.lecture_seat_id and is_delete = 0 and r_student_operation.lecture_id = ? and r_student_operation.student_id not in (select student_id from r_student_accomplishment where lecture_id = ?) order by operation_id LIMIT ?,? ;';
        // params = [lecture_id];
        params = [lecture_id,lecture_id,start,pageSize];

    }
    else {
        sqlStr = 'SELECT * FROM t_lecture_info,t_classroom_info,r_student_operation,t_student_info,r_lecture_seat where t_classroom_info.classroom_id = t_lecture_info.classroom_id and t_lecture_info.lecture_id = r_student_operation.lecture_id and t_student_info.student_id = r_student_operation.student_id and r_student_operation.seat_id = r_lecture_seat.lecture_seat_id and is_delete = 0 and r_student_operation.lecture_id = ? and r_student_operation.student_id not in (select student_id from r_student_accomplishment where lecture_id = ?) and t_student_info.student_no like ? order by operation_id LIMIT ?,? ;';
        params = [lecture_id,lecture_id,"%"+input+"%",start,pageSize];
    }
    conn.query(sqlStr,params,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            console.log(result[0]);
            res.json({success_code:200,data:result,total:total});
        }
    })
});

//将已完成任务的学生放到未完成列表，其实就是在完成表删除了此条记录
router.post('/api/admin/removeToNotFinishedStudent',function(req,res){
    let {
        lecture_id,
        student_id
    } = req.body;
    console.log(lecture_id);
    console.log(student_id);
    let sqlStr,params;
    if (lecture_id){
        let sqlStr = 'SELECT * from r_student_accomplishment WHERE lecture_id = ? and student_id = ?;';
        conn.query(sqlStr,[lecture_id,student_id],(error,result,field)=> {
            if (error) {
                console.log(error);
                res.json({success_code:0});
            }
            else {
                if (result[0]){
                    console.log("aaa");
                    let time = new Date();
                    sqlStr = 'delete from r_student_accomplishment where student_id = ? and lecture_id = ?;';
                    conn.query(sqlStr,[student_id,lecture_id,time],(error,result,field)=>{
                        if (error){
                            console.log(error);
                            res.json({success_code:0});
                        }
                        else {
                            sqlStr = 'select distinct * from r_student_accomplishment where student_id = ?;';
                            conn.query(sqlStr,[student_id],(error,result,field)=>{
                                if(error) {
                                    console.log(error);
                                    res.json({success_code:0});
                                }
                                else {
                                    if (result[0]){
                                        // console.log("aaa:"+result[0]);
                                        sqlStr = 'update t_student_info set lectures_num = ? where student_id = ?;';
                                        conn.query(sqlStr,[result.length,student_id],(error,result,field)=>{
                                            if (error) {
                                                console.log(error);
                                                res.json({success_code:0});
                                            }
                                            else{
                                                res.json({success_code:200});
                                            }
                                        });
                                    }
                                    else {
                                        sqlStr = 'update t_student_info set lectures_num = ? where student_id = ?;';
                                        conn.query(sqlStr,[0,student_id],(error,result,field)=>{
                                            if (error) {
                                                console.log(error);
                                                res.json({success_code:0});
                                            }
                                            else{
                                                res.json({success_code:200});
                                            }
                                        });
                                        // res.json({success_code:200});
                                    }
                                }
                            });
                        }
                    });
                }
                else {
                    res.json({success_code:0});
                }
            }
        })
    }
});


//确认此次讲座是否完成确认
router.get('/api/admin/getLectureIsConfirmed',function(req,res){
    let {
        lecture_id,
    } = req.query;
    console.log(lecture_id);
    let sqlStr,params;
    if (lecture_id){
        let sqlStr = 'SELECT * from r_student_operation WHERE lecture_id = ? and is_delete = 0;';
        conn.query(sqlStr,[lecture_id],(error,result,field)=> {
            if (error) {
                console.log(error);
                res.json({success_code:0});
            }
            else {
                if (result[0]){
                    let sqlStr = 'SELECT * from r_student_accomplishment WHERE lecture_id = ?;';
                    conn.query(sqlStr,[lecture_id],(error,result,field)=>{
                        if (error){
                            console.log(error);
                            res.json({success_code:0});
                        }
                        else{
                            if (result[0]){
                                res.json({success_code:200});
                            }else {
                                res.json({success_code:1});
                            }
                        }

                    })
                }
                else {
                    res.json({success_code:0});
                }
            }
        })
    }
});

//获取学生的讲座历史记录
router.get('/api/admin/getStudentLectureHistory',function(req,res){
    let {
        student_id,
    } = req.query;
    console.log(student_id);
    let sqlStr,params;
    if (student_id){
        let sqlStr = 'SELECT * from r_student_accomplishment WHERE student_id = ?;';
        conn.query(sqlStr,[student_id],(error,result,field)=> {
            if (error) {
                console.log(error);
                res.json({success_code:0});
            }
            else {
                if (result[0]){
                    let data=[];
                    let values=[];
                    for (let i = 0; i < result.length; i++) {
                         values.push(result[i].lecture_id);
                    }
                    sqlStr = 'select * from t_lecture_info where lecture_id in (?);';
                    conn.query(sqlStr,[values],(error,result,field)=>{
                        if (error) {
                            console.log(error);
                            res.json({success_code:0});
                        }
                        else {
                            console.log(result[0]);
                            data.push(result[0]);
                            res.json({success_code:200,data:data});
                        }
                    });
                }
                else {
                    res.json({success_code:0});
                }
            }
        })
    }
});

//获取学生的讲座历史记录
router.get('/api/admin/getLectureSeatList',function(req,res){
    let {
        lecture_id,
    } = req.query;
    console.log(lecture_id);
    let sqlStr,params;
    if (lecture_id){
        let sqlStr = 'SELECT * from r_lecture_seat WHERE lecture_id = ?;';
        conn.query(sqlStr,[lecture_id],(error,result,field)=> {
            if (error) {
                console.log(error);
                res.json({success_code:0});
            }
            else {
                if (result[0]){
                    res.json({success_code:200,data:result});
                }
                else {
                    res.json({success_code:0});
                }
            }
        })
    }
});

//获取操作记录
router.get('/api/admin/getStudentOperationList',function (req, res) {
    let {
        currentPage, pageSize,input
    } = req.query;
    let start = Number((currentPage-1)*pageSize);
    pageSize = Number(pageSize);
    let sqlStr;
    let params;
    if (input==="") {
        sqlStr = 'SELECT * from r_operation_record,t_lecture_info,t_student_info WHERE r_operation_record.lecture_id = t_lecture_info.lecture_id and r_operation_record.student_id = t_student_info.student_id order by record_id desc;';
        params = [];
    }
    else{
        sqlStr = 'SELECT * from r_operation_record,t_lecture_info,t_student_info WHERE r_operation_record.lecture_id = t_lecture_info.lecture_id and r_operation_record.student_id = t_student_info.student_id and student_no like ? order by record_id desc;';
        params = ["%"+input+"%"];
    }
    let total;
    conn.query(sqlStr,params,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            total = result.length;
        }
    });
    if ( input==="") {
        sqlStr = 'SELECT * from r_operation_record,t_lecture_info,t_student_info WHERE r_operation_record.lecture_id = t_lecture_info.lecture_id and r_operation_record.student_id = t_student_info.student_id order by record_id desc LIMIT ?,? ;';
        params = [start,pageSize];

    }
    else {
        sqlStr = 'SELECT * from r_operation_record,t_lecture_info,t_student_info WHERE r_operation_record.lecture_id = t_lecture_info.lecture_id and r_operation_record.student_id = t_student_info.student_id and student_no like ? order by record_id desc LIMIT ?,? ;';
        params = ["%"+input+"%",start,pageSize];
    }
    conn.query(sqlStr,params,(error,result,field)=>{
        if (error){
            console.log(error);
        } else{
            result = JSON.parse(JSON.stringify(result));
            console.log(result[0]);
            res.json({success_code:200,data:result,total:total});
        }
    })
});


module.exports = router;





