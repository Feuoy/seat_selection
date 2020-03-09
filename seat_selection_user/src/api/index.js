import ajax from './ajax'


//登录
export const login = (studentNo, studentPassword) => ajax('/user/api/login', {studentNo, studentPassword}, 'POST');

// 忘记密码时获取用户信息
export const getProtectionInfoByStudentNo = (studentNo) => ajax('/user/api/getProtectionInfoByStudentNo', {studentNo});


/*----------------------------------------------------------------------------------------------------------------*/


//获取用户信息
export const getStudentInfo = (studentId) => ajax('/user/api/getStudentInfo', {studentId});

//上传图片到服务器
export const upLoadImg = (formData) => ajax('/user/api/upLoadImg', formData, 'POST');

//更新头像
export const updateAvatar = (new_avatar, student_id) => ajax('/user/api/updateAvatar', {
  new_avatar,
  student_id
}, 'POST');

//获取密保信息
export const getProtectionInfo = (student_id) => ajax('/user/api/getProtectionInfo', {student_id});

//新增密保
export const addProtection = (protection_student_id, question_1, question_2, question_3, answer_1, answer_2, answer_3) => ajax('/user/api/addProtection', {
  protection_student_id,
  question_1,
  question_2,
  question_3,
  answer_1,
  answer_2,
  answer_3
}, 'POST');

// 更新密码
export const updatePassword = (new_password, student_id) => ajax('/user/api/updatePassword', {
  new_password,
  student_id
}, 'POST');


/*----------------------------------------------------------------------------------------------------------------*/


//获取当前页讲座
export const getCurrentPageLecture = (currentPage, pageSize, input) => ajax('/user/api/getCurrentPageLecture', {
  currentPage,
  pageSize,
  input
});

//获取课室信息
export const getClassroomInfo = (classroomId) => ajax('/user/api/getClassroomInfo', {classroomId});


/*----------------------------------------------------------------------------------------------------------------*/


// 查询讲座对应教室行列范围，其它接口代替传递了
export const getLectureClassroom = (lecture_id) => ajax('/user/api/getLectureClassroom', {lecture_id});

// 查已选座位
export const getLectureClassroomIsSelected = (lecture_id) => ajax('/user/api/getLectureClassroomIsSelected', {lecture_id});

// 通过讲座id、座位x、y，查询座位id
export const findSeatId = (lecture_id, seat_x, seat_y) => ajax('/user/api/findSeatId', {
  lecture_id,
  seat_x,
  seat_y
}, 'POST');

// 通过学生id（好友id）、讲座id，查询该学生是否选了该讲座
export const findLectureByStudentId = (student_id, lecture_id) => ajax('/user/api/findLectureByStudentId', {
  student_id,
  lecture_id
}, 'POST');


/*----------------------------------------------------------------------------------------------------------------*/


/*预约与删除预约，需要修改4个表，写了四个请求，有机会再改*/

// 1、r_lectrue_seat表
export const selectSeatUpdateSeat = (lecture_id, seat_x, seat_y) => ajax('/user/api/selectSeatUpdateSeat', {
  lecture_id,
  seat_x,
  seat_y
}, 'POST');
export const deleteOrderUpdateSeat = (lecture_id, seat_x, seat_y) => ajax('/user/api/deleteOrderUpdateSeat', {
  lecture_id,
  seat_x,
  seat_y
}, 'POST');

// 2、t_lectrue_info表
export const selectSeatUpdateLecture = (lecture_id) => ajax('/user/api/selectSeatUpdateLecture', {lecture_id}, 'POST');
export const deleteOrderUpdateLecture = (lecture_id) => ajax('/user/api/deleteOrderUpdateLecture', {lecture_id}, 'POST');

// 3、r_student_operation表
export const selectSeatUpdateOperation = (student_id, lecture_id, seat_id) => ajax('/user/api/selectSeatUpdateOperation', {
  student_id,
  lecture_id,
  seat_id
}, 'POST');
export const deleteOrderUpdateOperation = (student_id, lecture_id) => ajax('/user/api/deleteOrderUpdateOperation', {
  student_id,
  lecture_id
}, 'POST');

// 4、r_operation_record表
export const selectSeatUpdateRecord = (student_id, lecture_id) => ajax('/user/api/selectSeatUpdateRecord', {
  student_id,
  lecture_id
}, 'POST');
export const deleteOrderUpdateRecord = (student_id, lecture_id) => ajax('/user/api/deleteOrderUpdateRecord', {
  student_id,
  lecture_id
}, 'POST');


/*----------------------------------------------------------------------------------------------------------------*/


// 获取当前页已预约
export const getCurrentPageOrder = (student_id, currentPage, pageSize, input) => ajax('/user/api/getCurrentPageOrder', {
  student_id,
  currentPage,
  pageSize,
  input
});

// 获取已预约页讲座考核状态
export const readStudentLectureStatus = (student_id, lecture_id) => ajax('/user/api/readStudentLectureStatus', {
  student_id,
  lecture_id
}, 'POST');


/*----------------------------------------------------------------------------------------------------------------*/


//获取当前页收藏
export const getCurrentPageCollection = (student_id, currentPage, pageSize, input) => ajax('/user/api/getCurrentPageCollection', {
  student_id,
  currentPage,
  pageSize,
  input
});

//新增收藏
export const addCollection = (student_id, lecture_id) => ajax('/user/api/addCollection', {
  student_id,
  lecture_id
}, 'POST');

//删除收藏
export const deleteCollection = (student_id, lecture_id) => ajax('/user/api/deleteCollection', {
  student_id,
  lecture_id
}, 'POST');


/*----------------------------------------------------------------------------------------------------------------*/


//获取当前页好友
export const getCurrentPageRelationship = (main_student_id, currentPage, pageSize, input) => ajax('/user/api/getCurrentPageRelationship', {
  main_student_id,
  currentPage,
  pageSize,
  input
}, 'POST');

//删除好友
export const deleteRelationship = (main_student_id, fellow_student_id) => ajax('/user/api/deleteRelationship', {
  main_student_id,
  fellow_student_id
}, 'POST');

//新增好友
export const addRelationship = (main_student_id, fellow_student_no, fellow_student_friend_code) => ajax('/user/api/addRelationship', {
  main_student_id,
  fellow_student_no,
  fellow_student_friend_code
}, 'POST');

