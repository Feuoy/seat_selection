import Vue from 'vue'
import Router from 'vue-router'
import Login from '../components/Login/Login'
import HelloWorld from '@/components/HelloWorld'
import Home from "../components/Home/Home";
import UserManage from "../components/Home/children/UserManage";
import ClassroomManage from "../components/Home/children/ClassroomManage";
import LectureManage from "../components/Home/children/LectureManage";
import EditLectureInfo from "../components/Home/children/EditLectureInfo";
import LectureSeat from "../components/Home/children/LectureSeat";
import LectureStudentDetail from "../components/Home/children/LectureStudentDetail";
import CheckLectureStudent from "../components/Home/children/CheckLectureStudent";
import StudentLectureHistory from "../components/Home/children/StudentLectureHistory";
import StudentOperationHistory from "../components/Home/children/StudentOperationHistory";
import LectureSeatOverlook from "../components/Home/children/LectureSeatOverlook";

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      redirect: '/login'
    },
    {
      path:'/login',
      name:'login',
      component:Login
    },
    {
      path:'/home',
      name:'home',
      component: Home,
      children:[
        {path:'/home',redirect: '/home/user_manage'},
        {path:'user_manage',component:UserManage,name:'UserManage'},
        {path:'classroom_manage',component:ClassroomManage},
        {path:'lecture_manage',component:LectureManage,name:'LectureManage'},
        {path:'edit_lecture_info',component:EditLectureInfo,name:'EditLectureInfo'},
        {path:'lecture_student_detail',component:LectureStudentDetail,name:'LectureStudentDetail'},
        {path:'check_lecture_student',component:CheckLectureStudent,name:'CheckLectureStudent'},
        {path:'student_lecture_history',component:StudentLectureHistory,name:'StudentLectureHistory'},
        {path:'student_operation_history',component:StudentOperationHistory,name:'StudentOperationHistory'}
      ]
    },
    {
      path: '/lectureSeat',
      name: 'LectureSeat',
      component: LectureSeat,
      beforeRouteLeave: (to, from, next) => {
        console.log('hello')
        next(false)
      }
    },
    {
      path: '/lectureSeatOverlook',
      name: 'LectureSeatOverlook',
      component: LectureSeatOverlook,
      beforeRouteLeave: (to, from, next) => {
        next(false)
      }
    }
  ]
})
