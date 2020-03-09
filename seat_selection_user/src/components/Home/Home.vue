<template>
  <div id="home">

    <el-row class="header">
      <div class="head-bar" v-if="studentInfo.student_name">

        <div class="left">
          <img :src="server+'/images/logo.png'" class="icon-film-logo" style="font-size: 48px;margin-right: 5px;"></img>
          <span slot="title" style="color: rgba(40,40,40,0.74); font-size: 16px;font-weight: bolder">形势与政策 · 选座系统</span>
        </div>

        <el-menu :default-active="currentMenuIndex"
                 style="background-color: rgba(255, 255, 255, .1); margin-top: 0px; margin-bottom: 0px;"
                 mode="horizontal"
                 class="el-menu-vertical">

          <el-menu-item
            style="background-color: rgba(25,137,250,0.2); min-width: 160px; height: 100%;"
            :class="isSelect === '/student_info' ? 'active_card' : ''" index="/student_info"
            @click="handleMenuItemClick('/student_info')">
            <i class="el-icon-s-kpi"></i>
            <span slot="title">个人中心</span>
          </el-menu-item>

          <el-menu-item
            style="background-color: rgba(25,137,250,0.2); min-width: 160px;"
            :class="isSelect === '/lecture_list' ? 'active_card' : ''" index="/lecture_list"
            @click="handleMenuItemClick('/lecture_list')">
            <i class="el-icon-s-kpi"></i>
            <span slot="title">近期讲座</span>
          </el-menu-item>

          <el-menu-item
            style="background-color: rgba(25,137,250,0.2); min-width: 160px;"
            :class="isSelect === '/lecture_order' ? 'active_card' : ''" index="/lecture_order"
            @click="handleMenuItemClick('/lecture_order')">
            <i class="el-icon-s-kpi"></i>
            <span slot="title">已预约</span>
          </el-menu-item>

          <el-menu-item
            style="background-color: rgba(25,137,250,0.2); min-width: 160px;"
            :class="isSelect === '/collection_list' ? 'active_card' : ''" index="/collection_list"
            @click="handleMenuItemClick('/collection_list')">
            <i class="el-icon-s-kpi"></i>
            <span slot="title">我的收藏</span>
          </el-menu-item>

          <el-menu-item
            style="background-color: rgba(25,137,250,0.2); min-width: 160px;"
            :class="isSelect === '/relationship_list' ? 'active_card' : ''" index="/relationship_list"
            @click="handleMenuItemClick('/relationship_list')">
            <i class="el-icon-s-kpi"></i>
            <span slot="title">我的好友</span>
          </el-menu-item>

        </el-menu>

        <div class="right">

          <el-dropdown style="margin-left:12px">
            <span class="el-dropdown-link">
              {{studentInfo.student_name}}
            </span>
            <el-dropdown-menu slot="dropdown"></el-dropdown-menu>
          </el-dropdown>

          <el-link type="primary" style="float:right; margin-left: 50px" @click.native="logout" plain>
            退出
            <i class="el-icon-switch-button el-icon--right"></i>
          </el-link>

        </div>

      </div>
    </el-row>

    <!-- 页面主体内容 -->
    <el-row class="container" style="margin-top: 50px">
      <div class="section">
        <router-view style="background-color: rgba(255, 255, 255, .95);" class="content"/>
      </div>
    </el-row>

  </div>
</template>


<script>
    import Vue from "vue";
    import {
        Message,
        Dropdown,
        DropdownMenu,
        DropdownItem,
        RadioGroup,
        RadioButton
    } from "element-ui";
    import {getStudentInfo} from "../../api";

    Vue.component(Dropdown.name, Dropdown);
    Vue.component(DropdownMenu.name, DropdownMenu);
    Vue.component(DropdownItem.name, DropdownItem);
    Vue.component(RadioGroup.name, RadioGroup);
    Vue.component(RadioButton.name, RadioButton);

    export default {
        name: "Home",

        data() {
            return {
                //服务器地址
                server: "http://localhost:8081",
                studentInfo: {},
                currentMenuIndex: this.$cookies.get("isSelect"),
                isSelect: '',
                theAvatar: '',
            };
        },

        created() {
            this.loadStudentInfo();
        },

        methods: {

            // 获取用户信息
            async loadStudentInfo() {
                if (this.$cookies.get("student_id")) {
                    let json = await getStudentInfo(this.$cookies.get("student_id"));
                    if (json.success_code === 200) {
                        this.studentInfo = json.data;
                        this.theAvatar = json.data.avatar;
                    }
                } else {
                    this.$router.push({path: "/login"});
                    Message.error("请先登录！");
                }
            },

            // 点击导航栏事件
            handleMenuItemClick(path) {
                this.$router.push('/home' + path);
                this.currentMenuIndex = path;
                this.$cookies.set("isSelect", this.currentMenuIndex)
            },

            // 登出
            logout() {
                this.$cookies.remove("student_id");
                this.$router.push("/login");
                Message.success("退出成功！");
            },

        }
    };
</script>

<style scoped>
  #home {
    width: 100%;
    height: 100%;
    background: url('../../common/image/bg_user.jpg');
    background-size: cover;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-flow: column;
    color: #fff;
  }

  .left,
  .right {
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    height: 100%;
    min-width: 1200px;
  }

  .container .section {
    width: 80%;
    min-width: 1200px;
    display: flex;
    justify-content: center;
    align-content: flex-start;
    height: 100%;
    box-sizing: border-box;
    margin-top: 30px;
  }

  .nav-bar {
    width: 10%;
    min-width: 200px;
    border-bottom: 1px solid #e9eaeb;
  }

  .container .content {
    width: 90%;
    min-width: 1000px;
    height: 720px;
    padding-top: 30px;
    background-color: #fff;
    border: 1px solid #e9eaeb;
    border-left: none;
    box-shadow: 0 2px 4px 0 rgba(0, 0, 0, .05);
  }
</style>
<style>
  #home .header {
    background-color: rgba(255, 255, 255, .8);
    width: 100%;
    min-width: 1200px;
    height: 80px;
    display: flex;
    justify-content: center;
    align-items: center;
    box-shadow: 0 0 8px 1px #ccc;
    z-index: 9;
  }

  #home .header .head-bar {
    height: 100%;
    width: 80%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    min-width: 1200px;
  }

  #home .el-dropdown-link {
    cursor: pointer;
    font-size: 14px;
  }

  #home .el-dropdown-link:hover {
    color: #409eff;
  }

  #home .el-icon-arrow-down {
    font-size: 12px;
  }

  #home .el-menu {
    border: none;
    border: 1px solid #e9eaeb;
    box-shadow: 0 2px 4px 0 rgba(0, 0, 0, .05);
  }

  #home .el-menu-item {
    height: 50px;
    line-height: 50px;
  }

  #home .el-menu-item, #home .el-menu-item i {
    color: #3c4043;
  }

  #home .el-menu-item.is-active {
    color: #fff;
    background-color: #409eff;
  }

  #home .el-menu-item.is-active i {
    color: #fff;
  }

  .active_card {
    color: #fff;
    background-color: #409eff;
  }
</style>
