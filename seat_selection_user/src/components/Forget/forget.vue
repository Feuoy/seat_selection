<template>
  <div id="forget">
    <div class="box_forget">

      <el-form :label-position="labelPosition" label-width="90px"
               :model="ruleForm" status-icon :rules="rules" ref="ruleForm" class="demo-ruleForm">

        <h3>忘记密码</h3>

        <el-form-item label="您的学号 ： " prop="studentNo">
          <el-input v-model="ruleForm.studentNo" clearable placeholder="请输入学号" style="width: 218px"></el-input>
        </el-form-item>

        <el-form-item label="您的问题 ： " prop="value">
          <el-col :span="16">
            <el-select v-model="value" placeholder="请选择" style="width: 218px">
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </el-col>
        </el-form-item>

        <el-form-item label="您的答案 ： " prop="answer">
          <el-input v-model="ruleForm.answer" style="width: 218px" clearable placeholder="请输入您的答案"></el-input>
        </el-form-item>

        <el-form-item label="新密码 ： " prop="pass">
          <el-input type="password" v-model="ruleForm.pass" autocomplete="off" style="width: 218px" clearable
                    placeh older="请输入学号"></el-input>
        </el-form-item>

        <el-form-item label="确认密码 ： " prop="checkPass">
          <el-input type="password" v-model="ruleForm.checkPass" autocomplete="off" style="width: 218px" clearable
                    placeholder="请输入学号"></el-input>
        </el-form-item>

        <el-form-item style="margin-top: 30px">
          <el-button @click="goBack">返回</el-button>
          <el-button type="primary" size="medium" @click="doUpdatePassword('ruleForm')">确定</el-button>
        </el-form-item>

      </el-form>

    </div>
  </div>
</template>

<script>
    import Vue from "vue";
    import {Input, Button, Message, Form, FormItem} from "element-ui";
    import {
        getProtectionInfoByStudentNo,
        updatePassword,
    } from '../../api/index'

    Vue.use(Input);
    Vue.use(Button);

    export default {
        name: "Forget",

        data() {
            var checkStudentNo = (rule, value, callback) => {
                if (!value) {
                    return callback(new Error('答案不能为空'));
                }
                setTimeout(() => {
                    if (value.length !== 10) {
                        callback(new Error('学号为十位数字值'));
                    } else {
                        this.loadProtectionInfo();
                        callback();
                    }
                }, 500);
            };

            var checkAnswer = (rule, value, callback) => {
                if (!value) {
                    return callback(new Error('答案不能为空'));
                }
            };

            var validatePass = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请输入密码'));
                } else {
                    if (this.ruleForm.checkPass !== '') {
                        this.$refs.ruleForm.validateField('checkPass');
                    }
                    callback();
                }
            };

            var validatePass2 = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请再次输入密码'));
                } else if (value !== this.ruleForm.pass) {
                    callback(new Error('两次输入密码不一致!'));
                } else {
                    callback();
                }
            };

            return {
                labelPosition: "right",

                ProtectionInfo: {},
                options: {},
                value: '',

                ruleForm: {
                    pass: '',
                    checkPass: '',
                    answer: '',
                    studentNo: ''
                },

                rules: {
                    pass: [
                        {validator: validatePass, trigger: 'blur'}
                    ],
                    checkPass: [
                        {validator: validatePass2, trigger: 'blur'}
                    ],
                    answer: [
                        {validator: checkAnswer, trigger: 'blur'}
                    ],
                    studentNo: [
                        {validator: checkStudentNo, trigger: 'blur'}
                    ]
                },

            };
        },

        methods: {

            // 根据输入的学号获取密保信息
            async loadProtectionInfo() {
                if (this.ruleForm.studentNo) {
                    let json = await getProtectionInfoByStudentNo(this.ruleForm.studentNo);
                    if (json.success_code === 200) {
                        this.ProtectionInfo = json.data;
                        let str = [];
                        let a = {};
                        let b = {};
                        let c = {};
                        a['value'] = this.ProtectionInfo.question_1;
                        a['label'] = this.ProtectionInfo.question_1;
                        str.push(a);
                        b['value'] = this.ProtectionInfo.question_2;
                        b['label'] = this.ProtectionInfo.question_2;
                        str.push(b);
                        c['value'] = this.ProtectionInfo.question_3;
                        c['label'] = this.ProtectionInfo.question_3;
                        str.push(c);
                        this.options = str;
                    }
                }
            },

            // 修改密码
            async doUpdatePassword(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        alert('submit!');
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
                if (this.ruleForm.answer && this.ruleForm.pass) {
                    let isRight = false;
                    if (
                        (this.value === this.ProtectionInfo.question_1 && this.ruleForm.answer === this.ProtectionInfo.answer_1)
                        || (this.value === this.ProtectionInfo.question_2 && this.ruleForm.answer === this.ProtectionInfo.answer_2)
                        || (this.value === this.ProtectionInfo.question_3 && this.ruleForm.answer === this.ProtectionInfo.answer_3)
                    ) {
                        isRight = true;
                        let json = await updatePassword(this.ruleForm.pass, this.ProtectionInfo.student_id);
                        if (json.success_code === 200) {
                            this.loadProtectionInfo();
                            Message.success('修改密码成功，3秒后跳转至登录页面 ！');
                            setTimeout(() => {
                                this.$router.push({path: "/login"});
                            }, 3000);
                        } else if (json.error_code === 1) {
                            Message.error(json.message);
                        }
                    } else {
                        Message.error('答案错误！');
                    }
                } else {
                    Message.error('请完成必填内容！');
                }
            },

            // 返回登录页
            goBack() {
                this.$router.push({path: "/login"});
            },

        }
    };
</script>

<style>
  #forget {
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

  .box_forget {
    width: 540px;
    height: 540px;
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
