import ajax from './ajax'

//登录
export const login = (userNo,password)=>ajax('/admin/api/admin/login',{userNo,password},'POST');

//获取管理员信息
export const getAdminInfo = (adminId)=>ajax('/admin/api/admin/getAdminInfo',{adminId});

//获取当前页用户
export const getCurrentPageUser = (currentPage,pageSize)=>ajax('/admin/api/admin/getCurrentPageStudents',{currentPage,pageSize});

//上传图片到服务器
export const upLoadImg = (formData)=>ajax('/admin/api/admin/upLoadImg',formData,'POST');

//更新用户信息
export const updateStudentInfo = (student_id,student_no,student_name,gender,grade,faculty,major,lectures_num,id_no,student_password,avatar)=>ajax('/admin/api/admin/updateStudentInfo',{student_id,student_no,student_name,gender,grade,faculty,major,lectures_num,id_no,student_password,avatar},'POST');

//删除用户信息
export const deleteStudentInfo = (studentId)=>ajax('/admin/api/admin/deleteStudentInfo',{studentId},'POST');

//添加用户信息
export const addStudentInfo = (student_no,student_name,gender,grade,faculty,major,lectures_num,id_no,student_password,avatar)=>ajax('/admin/api/admin/addStudentInfo',{student_no,student_name,gender,grade,faculty,major,lectures_num,id_no,student_password,avatar},'POST');

//按照学号模糊搜索学生
export const getStudentByStudentNo = (currentPage,pageSize,student_no)=>ajax('/admin/api/admin/getStudentByStudentNo',{currentPage,pageSize,student_no});

//获取当前页教室
export const getCurrentPageClassroom = (currentPage,pageSize,input)=>ajax('/admin/api/admin/getCurrentPageClassroom',{currentPage,pageSize,input});

//获取教室楼栋
export const getClassroomBuilding = ()=>ajax('/admin/api/admin/getClassroomBuilding',{});

//通过楼栋获取教室信息
export const getClassroomByBuilding = (building)=>ajax('/admin/api/admin/getClassroomByBuilding',{building});

//通过楼栋和位置获取教室信息
export const getClassroomByBuildingAndLocation = (building,location)=>ajax('/admin/api/admin/getClassroomByBuildingAndLocation',{building,location});

//通过教室id获取教室信息
export const getClassroomById = (classroom_id)=>ajax('/admin/api/admin/getClassroomById',{classroom_id});

//更新教室信息
export const updateClassroomInfo = (classroom_id,building,location,row_num,column_num,capacity)=>ajax('/admin/api/admin/updateClassroomInfo',{classroom_id,building,location,row_num,column_num,capacity},'POST');

//删除教室信息
export const deleteClassroomInfo = (classroom_id)=>ajax('/admin/api/admin/deleteClassroomInfo',{classroom_id},'POST');

//添加教室信息
export const addClassroomInfo = (building,location,row_num,column_num,capacity)=>ajax('/admin/api/admin/addClassroomInfo',{building,location,row_num,column_num,capacity},'POST');

//获取当前页讲座
export const getCurrentPageLecture = (currentPage,pageSize,input)=>ajax('/admin/api/admin/getCurrentPageLecture',{currentPage,pageSize,input});

//更新讲座信息
export const updateLectureInfo = (lecture_id,title,teacher,introduction,image,classroom_id,start_time,end_time,total_seats_num,seats_selected_num,application_deadline)=>ajax('/admin/api/admin/updateLectureInfo',{lecture_id,title,teacher,introduction,image,classroom_id,start_time,end_time,total_seats_num,seats_selected_num,application_deadline},'POST');

//添加讲座信息
export const addLectureInfo = (title,teacher,introduction,image,classroom_id,start_time,end_time,total_seats_num,seats_selected_num,application_deadline)=>ajax('/admin/api/admin/addLectureInfo',{title,teacher,introduction,image,classroom_id,start_time,end_time,total_seats_num,seats_selected_num,application_deadline},'POST');

//上传讲座海报图片到服务器
export const upLoadLecturePosterImg = (formData)=>ajax('/admin/api/admin/upLoadPosterImg',formData,'POST');

//删除讲座信息
export const deleteLectureInfo = (lecture_id)=>ajax('/admin/api/admin/deleteLectureInfo',{lecture_id},'POST');

//根据讲座id获取讲座信息
export const getLectureInfoById = (lecture_id)=>ajax('/admin/api/admin/getLectureInfoById',{lecture_id});

//插入座位
export const insertSeat = (seats_info,lecture_id)=>ajax('/admin/api/admin/addLectureSeatInfo',{seats_info,lecture_id},'POST');

//获取当前页报名讲座的学生
export const getCurrentPageLectureStudents = (lecture_id,currentPage,pageSize,input)=>ajax('/admin/api/admin/getCurrentPageLectureStudents',{lecture_id,currentPage,pageSize,input});

//删除学生的讲座记录
export const deleteLectureStudentInfo = (lecture_id,student_id,seat_id)=>ajax('/admin/api/admin/deleteLectureStudentInfo',{lecture_id,student_id,seat_id},'POST');

//确认学生的讲座记录
export const confirmLectureStudentInfo = (lecture_id,student_id)=>ajax('/admin/api/admin/confirmLectureStudentInfo',{lecture_id,student_id},'POST');

//获取完成此次讲座的学生
export const getCurrentPageLectureFinishedStudents = (lecture_id,currentPage,pageSize,input)=>ajax('/admin/api/admin/getCurrentPageLectureFinishedStudents',{lecture_id,currentPage,pageSize,input});

//获取未完成此次讲座的学生
export const getCurrentPageLectureNotFinishedStudents = (lecture_id,currentPage,pageSize,input)=>ajax('/admin/api/admin/getCurrentPageLectureNotFinishedStudents',{lecture_id,currentPage,pageSize,input});

//将已完成任务的学生放到未完成的任务中
export const removeToNotFinishedStudent = (lecture_id,student_id)=>ajax('/admin/api/admin/removeToNotFinishedStudent',{lecture_id,student_id},'POST');

//确认此次讲座的全部学生
export const confirmLectureAllStudent = (lecture_id)=>ajax('/admin/api/admin/confirmAllLectureStudentInfo',{lecture_id},'POST');

//查询此次讲座是否被管理员所确认
export const checkIsConfirmed = (lecture_id)=>ajax('/admin/api/admin/getLectureIsConfirmed',{lecture_id});

//获取学生的讲座记录
export const getStudentLectureHistory = (student_id)=>ajax('/admin/api/admin/getStudentLectureHistory',{student_id});

//获取讲座的座位情况
export const getLectureSeatList = (lecture_id)=>ajax('/admin/api/admin/getLectureSeatList',{lecture_id});

//获取学生的操作历史
export const getStudentOperationList = (currentPage,pageSize,input)=>ajax('/admin/api/admin/getStudentOperationList',{currentPage,pageSize,input});

// 查已选座位
export const getLectureClassroomIsSelected = (lecture_id)=>ajax('/user/api/getLectureClassroomIsSelected',{lecture_id});
