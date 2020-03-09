import Vue from 'vue'
import Router from 'vue-router'
import Login from '../components/Login/Login'
import Forget from '../components/Forget/Forget'
import Home from '../components/Home/Home'
import LectureList from '../components/Home/children/LectureList'
import CollectionList from '../components/Home/children/CollectionList'
import LectureOrder from '../components/Home/children/LectureOrder'
import RelationshipList from '../components/Home/children/RelationshipList'
import StudentInfo from '../components/Home/children/StudentInfo'
import LectureSeat from "../components/Home/children/LectureSeat";

Vue.use(Router);

export default new Router({
  // mode: 'history',  //去掉url中的#
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
      path:'/forget',
      name:'forget',
      component:Forget
    },
    {
      path: '/home',
      name: 'home',
      component: Home,
      children:[
        {path:'student_info',component:StudentInfo},
        {path:'lecture_list',component:LectureList},
        {path:'lecture_order',component:LectureOrder},
        {path:'collection_list',component:CollectionList},
        {path:'relationship_list',component:RelationshipList},
        {path:'/home',redirect: '/home/student_info'}
      ]
    },
    {
      path: '/LectureSeat',
      name: 'LectureSeat',
      component: LectureSeat,
      beforeRouteLeave: (to, from, next) => {
        next(false)
      }
    }
  ]
})
