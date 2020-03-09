// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import cookies from 'vue-cookies'
import store from './entity/store'

import 'element-ui/lib/theme-chalk/index.css';

//配置字体图标
import "@/common/css/style.css";

Vue.config.productionTip = false;
Vue.use(cookies);

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: {App},
  template: '<App/>'
});
