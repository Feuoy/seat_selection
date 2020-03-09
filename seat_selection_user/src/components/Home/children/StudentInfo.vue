<template>
  <div id="student-list">

    <div class="student-table">

      <div>
        <br/><br/><br/><br/>
      </div>

      <div class="the_left">

        <el-form :label-position="labelPosition" label-width="100px" :model="studentInfo">

          <!--头像-->
          <el-form-item label="" prop="avatar">
            <el-col :span="16">
              <el-avatar shape="circle" :size="100" :src="studentInfo.avatar"></el-avatar>
            </el-col>
          </el-form-item>

          <el-form-item label="学号" prop="student_no">
            <el-col :span="16">
              <el-tag type="success">{{studentInfo.student_no}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="姓名" prop="student_name">
            <el-col :span="16">
              <el-tag type="success">{{studentInfo.student_name}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="性别" prop="gender">
            <el-col :span="16">
              <el-tag type="success">
                {{formatGender(studentInfo.gender)}}
              </el-tag>
            </el-col>
          </el-form-item>

        </el-form>

      </div>


      <div class="the_right">

        <el-form :label-position="labelPosition" label-width="100px" :model="studentInfo">

          <el-form-item label="年级" prop="grade">
            <el-col :span="16">
              <el-tag type="success">{{studentInfo.grade}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="学院" prop="faculty">
            <el-col :span="16">
              <el-tag type="success">{{studentInfo.faculty}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="专业" prop="major">
            <el-col :span="16">
              <el-tag type="success">{{studentInfo.major}}</el-tag>
            </el-col>
          </el-form-item>


          <el-form-item label="身份证号" prop="id_no">
            <el-col :span="16">
              <el-tag type="success">{{studentInfo.id_no}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="好友码" prop="friend_code">
            <el-col :span="16">
              <el-tag type="success">{{studentInfo.friend_code}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="已完成讲座数" prop="lectures_num">
            <el-col :span="16">
              <el-tag type="success">{{studentInfo.lectures_num}} / 16</el-tag>
            </el-col>
          </el-form-item>

        </el-form>

      </div>

    </div>

    <div>
      <br/><br/><br/><br/><br/>
    </div>

    <!--下部-->
    <div>

      <!--听课次数进度条-->
      <div style="text-align:center">
        <div class="progress">
          <el-progress :text-inside="true" :stroke-width="24" :percentage="percentage" :color="colors"></el-progress>
        </div>
      </div>

      <div style="text-align:center">

        <el-row>
          <el-col :span="8">
            <div class="grid-content bg-purple">
              <el-button class="three_button" type="success" size="medium" style="font-size: large" @click="editAvatar">
                修改头像
                <i class="el-icon-user el-icon--right"></i>
              </el-button>
            </div>
          </el-col>

          <el-col :span="8">
            <div class="grid-content bg-purple-light">
              <el-button class="three_button" type="danger" size="medium" style="font-size: large"
                         @click="updatePassword">
                修改密码
                <i class="el-icon-lock el-icon--right"></i>
              </el-button>
            </div>
          </el-col>

          <el-col :span="8">
            <div class="grid-content bg-purple">
              <el-button class="three_button" type="warning" size="medium" style="font-size: large"
                         @click="addProtection">
                添加密保
                <i class="el-icon-key el-icon--right"></i>
              </el-button>
            </div>
          </el-col>

        </el-row>

      </div>

    </div>

    <!---------------------------------------------------------------------------------------------------------->
    <!----------------------------------------------- 修改头像对话框 ----------------------------------------------->
    <!---------------------------------------------------------------------------------------------------------->

    <div>
      <el-dialog
        style="width: 1000px; margin: 0 auto"
        :title="dialogTitle"
        :visible.sync="dialogFormVisible"
        :modal-append-to-body="false"
        v-if="dialogFormVisible"
        :showClose="false"
      >

        <el-form
          style="margin-top: 50px"
          :label-position="labelPosition" label-width="80px" :model="studentInfo">

          <el-form-item label="" prop="avatar">
            <el-col :span="16">

              <el-avatar shape="circle" ref="previewImg" :size="100" :src="studentInfo.avatar"></el-avatar>

              <div style="position: relative;height: 64px; margin-top: 20px">

                <el-button size="small" type="primary" style="position: absolute;left: 0;top: 0;cursor: pointer">
                  上传
                  <i class="el-icon-upload el-icon--right"></i>
                </el-button>

                <input type="file" id="file" name="file" ref="uploadImg"
                       accept="image/png, image/jpeg, image/gif, image/jpg"
                       style="position: absolute;left: 0;top: 0;opacity: 0;height: 32px;width: 80px;cursor: pointer"
                       @change="changeImg">

              </div>

            </el-col>
          </el-form-item>

        </el-form>

        <div slot="footer" class="dialog-footer">

          <el-button @click="cancel">
            <i class="el-icon-close el-icon--right"></i>
          </el-button>

          <el-button type="primary" @click="manageAvatarInfo()">
            <i class="el-icon-check el-icon--right"></i>
          </el-button>

        </div>

      </el-dialog>
    </div>

    <!---------------------------------------------------------------------------------------------------------->
    <!----------------------------------------------- 添加密保对话框 ----------------------------------------------->
    <!---------------------------------------------------------------------------------------------------------->

    <div>
      <el-dialog
        style="width: 1500px; margin: 0 auto"
        :title="dialogTitle_addProtection"
        :visible.sync="dialogFormVisible_addProtection"
        :modal-append-to-body="false"
        v-if="dialogFormVisible_addProtection"
        :showClose="false"
      >

        <el-form :label-position="labelPosition" label-width="100px" :model="protectionInfo">

          <el-form-item label="问题 1 ： " prop="question_1">
            <el-col :span="16">
              <el-input v-model="protectionInfo.question_1"></el-input>
            </el-col>
          </el-form-item>

          <el-form-item label="答案 1 ： " prop="answer_1">
            <el-col :span="16">
              <el-input v-model="protectionInfo.answer_1"></el-input>
            </el-col>
          </el-form-item>

          <el-form-item label="问题 2 ： " prop="question_2">
            <el-col :span="16">
              <el-input v-model="protectionInfo.question_2"></el-input>
            </el-col>
          </el-form-item>

          <el-form-item label="答案 2 ： " prop="answer_2">
            <el-col :span="16">
              <el-input v-model="protectionInfo.answer_2"></el-input>
            </el-col>
          </el-form-item>

          <el-form-item label="问题 3 ： " prop="question_3">
            <el-col :span="16">
              <el-input v-model="protectionInfo.question_3"></el-input>
            </el-col>
          </el-form-item>

          <el-form-item label="答案 3 ： " prop="answer_3">
            <el-col :span="16">
              <el-input v-model="protectionInfo.answer_3"></el-input>
            </el-col>
          </el-form-item>

        </el-form>

        <div slot="footer" class="dialog-footer">

          <el-button @click="cancel_addProtection"><i class="el-icon-close el-icon--right"></i></el-button>

          <el-button type="primary" @click="manageProtectionInfo()"><i class="el-icon-check el-icon--right"></i>
          </el-button>

        </div>

      </el-dialog>
    </div>

    <!---------------------------------------------------------------------------------------------------------->
    <!----------------------------------------------- 修改密码对话框 ----------------------------------------------->
    <!---------------------------------------------------------------------------------------------------------->

    <div>
      <el-dialog
        style="width: 1400px; margin: 0 auto"
        :title="dialogTitle_updatePassword"
        :visible.sync="dialogFormVisible_updatePassword"
        :modal-append-to-body="false"
        v-if="dialogFormVisible_updatePassword"
        :showClose="false">

        <el-form :label-position="labelPosition" label-width="140px"
                 :model="ruleForm" status-icon :rules="rules" ref="ruleForm" class="demo-ruleForm">

          <el-form-item label="请选择一个问题 ： " prop="value">
            <el-col :span="16">
              <el-select v-model="value" placeholder="请选择">
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
            <el-input v-model="ruleForm.answer" style="width: 218px" clearable></el-input>
          </el-form-item>

          <el-form-item label="新密码 ： " prop="pass">
            <el-input type="password" v-model="ruleForm.pass" autocomplete="off" style="width: 218px"
                      clearable></el-input>
          </el-form-item>

          <el-form-item label="确认密码 ： " prop="checkPass">
            <el-input type="password" v-model="ruleForm.checkPass" autocomplete="off" style="width: 218px"
                      clearable></el-input>
          </el-form-item>

        </el-form>

        <div slot="footer" class="dialog-footer">

          <el-button @click="cancel_updatePassword">
            <i class="el-icon-close el-icon--right"></i>
          </el-button>

          <el-button type="primary" @click="managePassword('ruleForm')">
            <i class="el-icon-check el-icon--right"></i>
          </el-button>

        </div>

      </el-dialog>
    </div>

  </div>
</template>


<script>
    import {MessageBox, Message} from 'element-ui'
    import {
        getStudentInfo,
        upLoadImg,
        updateAvatar,
        addProtection,
        getProtectionInfo,
        updatePassword
    } from '../../../api/index'

    export default {
        name: "StudentList",

        data() {

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
                server: 'http://localhost:8081',

                labelPosition: 'right',
                dialogFormVisible: false,
                dialogTitle: '',
                dialogTitle_addProtection: '',
                dialogFormVisible_addProtection: false,
                dialogTitle_updatePassword: '',
                dialogFormVisible_updatePassword: false,

                studentInfo: {},
                protectionInfo: {},
                theStudentId: this.$cookies.get("student_id"),

                options: {},
                value: '',
                ruleForm: {
                    pass: '',
                    checkPass: '',
                    answer: ''
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
                    ]
                },

                ProgressInfo: {},
                thePercentage: this.$cookies.get("lectures_num"),
                colors: [
                    {color: '#f56c6c', percentage: 20},
                    {color: '#EE7942', percentage: 40},
                    {color: '#e6a23c', percentage: 60},
                    {color: 'rgba(25,137,250,0.68)', percentage: 80},
                    {color: '#5cb87a', percentage: 100}
                ],

            }
        },

        created() {
            this.loadStudentInfo();
            this.doProgress();
        },

        methods: {

            /*-------------------------------------------------- 加载学生信息 --------------------------------------*/

            // 获取学生信息
            async loadStudentInfo() {
                if (this.$cookies.get("student_id")) {
                    let json = await getStudentInfo(this.$cookies.get("student_id"));
                    if (json.success_code === 200) {
                        this.studentInfo = json.data;
                    }
                } else {
                    this.$router.push({path: "/login"});
                    Message.error("请先登录！");
                }
            },

            // 性别转换
            formatGender: function (theGender) {
                let gender = String(theGender);
                return gender === '1' ? "男" : gender === '0' ? "女" : "";
            },


            /*-------------------------------------------------- 更新头像 --------------------------------------*/

            //修改头像对话框
            editAvatar() {
                this.dialogTitle = '修改头像';
                this.dialogFormVisible = true;
            },

            // 上传
            changeImg(e) {
                let reader = new FileReader();
                reader.readAsDataURL(this.$refs.uploadImg.files[0]);//发起异步请求
                let _this = this;
                reader.onload = function () {
                    //读取完成后，将结果赋值给img的src
                    _this.$refs.previewImg.src = this.result;
                };
            },

            //修改头像
            async manageAvatarInfo() {
                if (this.$refs.uploadImg.files[0]) {
                    let formData = new FormData();
                    formData.append('file', this.$refs.uploadImg.files[0]);
                    let json = await upLoadImg(formData);
                    if (json.success_code === 200) {
                        if (json.data.length) {
                            this.studentInfo.avatar = '/images/avatar/user/' + json.data[0].filename;
                        }
                        this.dialogFormVisible = false;
                        json = await updateAvatar(this.studentInfo.avatar, this.theStudentId);
                        if (json.success_code === 200) {
                            this.loadStudentInfo();
                            this.dialogFormVisible = false;
                            Message.success('修改头像成功！');
                        } else if (json.error_code === 1) {
                            Message.error(json.message);
                        }
                    } else {
                        Message.error('上传失败，请重试！');
                    }
                } else {
                    Message.error('请上传头像！');
                }
            },

            // 取消修改头像
            cancel() {
                this.dialogFormVisible = false;
                this.loadStudentInfo();
            },

            /*-------------------------------------------------- 修改密码对话框 --------------------------------------*/

            // 修改密码对话框
            updatePassword() {
                this.loadProtectionInfo();
                this.dialogTitle_updatePassword = '修改密码';
                this.dialogFormVisible_updatePassword = true;
            },

            // 修改密码
            async managePassword(formName) {
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
                        (this.value === this.protectionInfo.question_1 && this.ruleForm.answer === this.protectionInfo.answer_1)
                        || (this.value === this.protectionInfo.question_2 && this.ruleForm.answer === this.protectionInfo.answer_2)
                        || (this.value === this.protectionInfo.question_3 && this.ruleForm.answer === this.protectionInfo.answer_3)
                    ) {
                        isRight = true;
                        let json = await updatePassword(this.ruleForm.pass, this.$cookies.get("student_id"));
                        if (json.success_code === 200) {
                            this.loadStudentInfo();
                            this.dialogFormVisible_updatePassword = false;
                            Message.success('修改密码成功！');
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

            // 取消修改密码
            cancel_updatePassword() {
                this.dialogFormVisible_updatePassword = false;
                this.loadStudentInfo();
            },

            /*-------------------------------------------------- 添加密保对话框 --------------------------------------*/

            // 添加密保对话框
            addProtection() {
                this.loadProtectionInfo();
                this.dialogTitle_addProtection = '添加密保';
                this.dialogFormVisible_addProtection = true;
            },

            // 添加密保
            async manageProtectionInfo() {
                if (this.protectionInfo.protection_student_id == null) {
                    if (this.protectionInfo.question_1
                        && this.protectionInfo.question_2
                        && this.protectionInfo.question_3
                        && this.protectionInfo.answer_1
                        && this.protectionInfo.answer_2
                        && this.protectionInfo.answer_3
                    ) {
                        let json = await addProtection(
                            this.theStudentId,
                            this.protectionInfo.question_1,
                            this.protectionInfo.question_2,
                            this.protectionInfo.question_3,
                            this.protectionInfo.answer_1,
                            this.protectionInfo.answer_2,
                            this.protectionInfo.answer_3,
                        );
                        if (json.success_code === 200) {
                            this.loadStudentInfo();
                            this.dialogFormVisible_addProtection = false;
                            Message.success('添加密保成功！');
                        } else if (json.error_code === 1) {
                            Message.error(json.message);
                        }
                    } else {
                        Message.error('请完成必填内容！');
                    }
                } else {
                    Message.warning('密保只能添加一次，您已添加过哦！');
                }
            },

            // 获取密保信息
            async loadProtectionInfo() {
                if (this.$cookies.get("student_id")) {
                    let json = await getProtectionInfo(this.$cookies.get("student_id"));
                    // let json = getProtectionInfo(this.$cookies.get("student_id"));
                    if (json.success_code === 200) {
                        this.protectionInfo = json.data;
                        let str = [];
                        let a = {};
                        let b = {};
                        let c = {};
                        a['value'] = this.protectionInfo.question_1;
                        a['label'] = this.protectionInfo.question_1;
                        str.push(a);
                        b['value'] = this.protectionInfo.question_2;
                        b['label'] = this.protectionInfo.question_2;
                        str.push(b);
                        c['value'] = this.protectionInfo.question_3;
                        c['label'] = this.protectionInfo.question_3;
                        str.push(c);
                        this.options = str;
                    }
                }
            },

            // 取消添加密保
            cancel_addProtection() {
                this.dialogFormVisible_addProtection = false;
                this.loadStudentInfo();
            },


            /*-------------------------------------------------- 听课次数进度条 --------------------------------------*/

            doProgress() {
                this.percentage = Number(this.thePercentage / 16 * 100);
            },

        },
    }
</script>

<style>
  .student-table {
    width: 90%;
    min-width: 900px;
    margin: 0 auto;
    margin-bottom: 30px;
    height: 50%;
  }

  .top {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 30px 0;
    margin-bottom: 30px;
  }

  .block {
    text-align: center;
  }

  .el-dialog__header {
    text-align: center;
  }

  .el-dialog__body .el-form-item {
    padding-left: 20%;
  }

  .the_left {
    height: 100%;
    width: 50%;
    float: left;
  }

  .the_right {
    height: 100%;
    width: 50%;
    float: left;
  }


  .three_button {
    height: 50px;
    width: 300px;
    margin: 0 auto;
    margin-top: 70px;
    opacity: 0.8;
  }

  .progress {
    height: 20px;
    width: 84%;
    margin-top: 10px;
    margin-left: 100px;
  }

  .el-row {
    margin-bottom: 20px;
  }

  .el-col {
    border-radius: 4px;
  }

  .bg-purple-dark {
  }

  .bg-purple {
  }

  .bg-purple-light {
  }

  .grid-content {
    border-radius: 4px;
    min-height: 36px;
  }

  .row-bg {
    padding: 10px 0;
    background-color: #f9fafc;
  }

</style>
