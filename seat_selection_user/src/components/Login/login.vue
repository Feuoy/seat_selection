<template>
  <div id="login">
    <div class="box_login">
      <el-form :label-position="labelPosition" label-width="50px">

        <h3>形势与政策 · 选座系统</h3>

        <el-form-item label="学号">
          <el-input v-model="loginNo" clearable placeholder="请输入学号"></el-input>
        </el-form-item>

        <el-form-item label="密码">
          <el-input placeholder="请输入密码" v-model="password" show-password></el-input>
        </el-form-item>

        <el-form-item style="margin-top: 30px">
          <el-button type="" @click="forget" style="width:25%;">忘记</el-button>
          <el-button type="primary" size="medium" @click="login" style="width:25%;">登录</el-button>
        </el-form-item>

      </el-form>
    </div>
  </div>
</template>

<script>
    import Vue from "vue";
    import {Input, Button, Message, Form, FormItem} from "element-ui";
    import {login} from "../../api";

    Vue.use(Input);
    Vue.use(Button);

    export default {
        name: "Login",

        data() {
            return {
                labelPosition: "right",
                loginNo: "",
                password: ""
            };
        },

        methods: {

            async login() {
                if (!this.loginNo) {
                    Message.error("请输入用户名！");
                } else if (!this.password) {
                    Message.error("请输入密码！");
                } else {
                    let json = await login(this.loginNo, this.password);
                    if (json.success_code === 200) {
                        Message.success("登录成功！");
                        this.$cookies.set("isSelect", "/student_info");
                        this.$router.push({path: "/home"});
                    } else {
                        Message.error(json.message);
                    }
                }
            } ,

            forget() {
                this.$router.push({path: "/forget"});
            }

        }
    };
</script>

<style>
  #login {
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

  .box_login {
    width: 530px;
    height: 430px;
    background-color: rgba(255, 255, 255, .8);
    display: flex;
    justify-content: center;
    align-items: center;
    flex-flow: column;
    border-radius: 4px;
    box-shadow: 0 0 8px 8px #ccc;
  }

  h3 {
    margin-bottom: 40px;
    font-size: 36px;
    letter-spacing: 2px;
    color: #888;
    text-align: center
  }
</style>
