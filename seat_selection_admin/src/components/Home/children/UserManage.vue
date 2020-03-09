<template>
  <div id="user-manage">
    <!--搜索-->
    <div class="top">
      <el-col :span="12">
        <el-input
          placeholder="请输入学号"
          v-model="input"
          class="input-with-select"
          clearable
          style="width: 100%"
        >
          <el-button slot="append" icon="el-icon-search" @click="search">搜索</el-button>
        </el-input>
      </el-col>
      <el-col :span="2" :offset="1">
        <el-button type="primary" size="small" @click="addUser">添加学生</el-button>
      </el-col>
    </div>
    <!--表格-->
    <div class="user-table">
      <el-table border :data="tableData">
        <el-table-column label="学号" align="center" width="120" prop="student_no"></el-table-column>
        <el-table-column
          label="学生姓名"
          align="center"
          width="120"
          show-overflow-tooltip
          prop="student_name"
        ></el-table-column>
        <el-table-column label="性别" align="center" width="60">
          <template slot-scope="scope">
            {{ scope.row.gender === 0 ? '女':'男'}}
          </template>
        </el-table-column>
        <el-table-column label="学院" align="center" width="120" prop="faculty"></el-table-column>
        <el-table-column label="专业" align="center" width="120" prop="major"></el-table-column>
        <el-table-column show-overflow-tooltip label="操作" align="center">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
            <el-button size="mini" @click="handleDetail(scope.$index, scope.row)">详情</el-button>
            <el-button size="mini" @click="handleStory(scope.$index, scope.row)">讲座历史记录</el-button>
            <el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <!--分页-->
    <div class="block" v-if="tableData.length">
      <el-pagination
        @current-change="currentChange"
        background
        layout="prev, pager, next"
        :page-size="8"
        :total="total"
      ></el-pagination>
    </div>
    <!--用户弹框-->
    <div>
      <el-dialog
        :title="dialogTitle"
        :visible.sync="dialogFormVisible"
        :modal-append-to-body="false"
        v-if="dialogFormVisible"
        :show-close="false"
      >
        <el-form
          :label-position="labelPosition"
          :rules="rules"
          label-width="80px"
          :model="userInfo"
        >
          <el-form-item label="学号" prop="student_no">
            <el-col :span="16">
<!--              {{userInfo.student_no}}-->
              <el-input v-model="userInfo.student_no"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="姓名" prop="student_name">
            <el-col :span="16">
<!--              {{userInfo.student_name}}-->
              <el-input v-model="userInfo.student_name"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="照片">
            <el-col :span="16">
              <img
                :src="userInfo.avatar ? userInfo.avatar: server+'/images/avatar/bnuz.jpg'"
                ref="previewImg"
                alt
                width="80px"
                height="80px"
              />
              <div style="position: relative;height: 64px">
                <el-button
                  size="small"
                  type="primary"
                  style="position: absolute;left: 0;top: 0;cursor: pointer"
                >点击上传</el-button>
                <input
                  type="file"
                  id="file"
                  name="file"
                  ref="uploadImg"
                  accept="image/png, image/jpeg, image/gif, image/jpg"
                  style="position: absolute;left: 0;top: 0;opacity: 0;height: 32px;width: 80px;cursor: pointer"
                  @change="changeImg"
                />
                <div
                  slot="tip"
                  class="el-upload__tip"
                  style="position: absolute;left: 0;top: 32px;height: 32px"
                >只能上传jpg/png文件，且不超过500kb（默认为系统头像）</div>
              </div>
            </el-col>
          </el-form-item>
          <el-form-item label="年级" prop="grade">
            <el-col :span="16">
              <el-input v-model="userInfo.grade"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="学院" prop="faculty">
            <el-col :span="16">
              <el-input v-model="userInfo.faculty"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="专业" prop="major">
            <el-col :span="16">
              <el-input v-model="userInfo.major"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="密码" prop="student_password">
            <el-col :span="16">
              <el-input v-model="userInfo.student_password" show-password></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="性别">
            <el-col :span="16">
              <el-select  v-model="genderSelected" :placeholder="genderTips" style="width: 100%">
                <el-option label="男" value="男"></el-option>
                <el-option label="女" value="女"></el-option>
              </el-select>
            </el-col>
          </el-form-item>
          <el-form-item label="身份证号" prop="id_no">
            <el-col :span="16">
<!--              {{userInfo.id_no}}-->
              <el-input v-model="userInfo.id_no"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="听课次数" prop="lectures_num">
            <el-col :span="16">
              <el-input v-model="userInfo.lectures_num"></el-input>
            </el-col>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="cancel">取 消</el-button>
          <el-button type="primary" @click="manageUserInfo()">确 定</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>
<script>
  import {
    getCurrentPageUser,
    upLoadImg,
    deleteStudentInfo, updateStudentInfo, addStudentInfo, getStudentByStudentNo
  } from "../../../api/index";
  import { MessageBox, Message } from "element-ui";
  export default {
    name: "UserManage",
    data() {
      return {
        //服务器地址
        server: "http://localhost:8081",
        tableData: [],
        total: 0,
        currentPage: 1,
        userInfo: {},
        dialogFormVisible: false,
        dialogTitle: "",
        labelPosition: "right",
        input: "",
        searchInput: "",
        rules: {
          user_name: [
            { required: true, message: "请输入用户名", trigger: "blur" }
          ],
          password: [{ required: true, message: "请输入密码", trigger: "blur" }]
        },
        genderSelected : '',
        genderTips:'请选择性别'
      };
    },
    created() {
      this.loadCurrentPageUser(this.currentPage, 8, "");
    },
    methods: {
      async loadCurrentPageUser(currentPage, pageSize) {
        let json = await getCurrentPageUser(currentPage, pageSize);
        if (json.success_code === 200) {
          this.tableData = json.data;
          this.total = json.total;
        }
      },
      async getStudentByStudentNo(currentPage,pageSize,student_no){
        let json = await getStudentByStudentNo(currentPage, pageSize,student_no);
        if (json.success_code === 200) {
          this.tableData = json.data;
          this.total = json.total;
        }
      },
      handleEdit(index, row) {
        this.dialogTitle = "编辑用户信息";
        this.userInfo = row;
        this.dialogFormVisible = true;
        this.genderSelected = this.userInfo.gender === 0 ? '女' : '男';
      },
      handleDetail(index,row){
        this.dialogTitle = "查看用户信息";
        this.userInfo = row;
        this.dialogFormVisible = true;
        this.genderSelected = this.userInfo.gender === 0 ? '女' : '男';
      },
      handleStory(index,row){
        this.userInfo = row;
        this.$router.push({ name:'StudentLectureHistory',params:{userInfo:this.userInfo} });
      },
      handleDelete(index, row) {
        MessageBox.confirm(
          "此操作将永久删除姓名为"+row.student_name+"的学生的所有信息, 是否继续？",
          "提示",{
            type:'warning'
          }
        ).then(async value => {
          if (value === "confirm") {
            let json = await deleteStudentInfo(row.student_id);
            if (json.success_code === 200) {
              Message.success("删除该学生成功！");
              this.loadCurrentPageUser(this.currentPage, 8, this.searchInput);
            }
          }
        });
        console.log(index, row);
      },
      async currentChange(currentPage) {
        this.currentPage = currentPage;
        this.loadCurrentPageUser(this.currentPage, 8, this.searchInput);
      },
      changeImg(e) {
        let reader = new FileReader();
        reader.readAsDataURL(this.$refs.uploadImg.files[0]); //发起异步请求
        let _this = this;
        reader.onload = function() {
          //读取完成后，将结果赋值给img的src
          _this.$refs.previewImg.src = this.result;
          _this.userInfo.avatar = this.result;
        };
      },
      //修改或添加用户信息
      async manageUserInfo() {
        if (
          !this.userInfo.student_name
        ) {
          Message.error("请完成必填内容！");
          console.log(this.userInfo.gender);
          return false;
        } else {
          let formData = new FormData();
          formData.append("file", this.$refs.uploadImg.files[0]);
          let json = await upLoadImg(formData);
          if (json.success_code === 200) {
            if (json.data.length) {
              this.userInfo.avatar = "/images/avatar/user/" + json.data[0].filename;
            }
            if (this.genderSelected === '男'){
              this.userInfo.gender = 1;
            }
            else {
              this.userInfo.gender = 0;
            }
            if (this.dialogTitle === "编辑用户信息") {
              json = await updateStudentInfo(
                this.userInfo.student_id,
                this.userInfo.student_no,
                this.userInfo.student_name,
                this.userInfo.gender,
                this.userInfo.grade,
                this.userInfo.faculty,
                this.userInfo.major,
                this.userInfo.lectures_num,
                this.userInfo.id_no,
                this.userInfo.student_password,
                this.userInfo.avatar
              );
              if (json.success_code === 200) {
                this.dialogFormVisible = false;
                Message.success("修改用户信息成功！");
              } else if (json.error_code === 1) {
                Message.error(json.message);
              }
            } else {
              json = await addStudentInfo(
                this.userInfo.student_no,
                this.userInfo.student_name,
                this.userInfo.gender,
                this.userInfo.grade,
                this.userInfo.faculty,
                this.userInfo.major,
                this.userInfo.lectures_num,
                this.userInfo.id_no,
                this.userInfo.student_password,
                this.userInfo.avatar
              );
              if (json.success_code === 200) {
                this.loadCurrentPageUser(this.currentPage, 8, this.searchInput);
                this.dialogFormVisible = false;
                Message.success("添加用户成功！");
              } else if (json.error_code === 1) {
                Message.error(json.message);
              }
            }
          }
        }
      },
      cancel() {
        this.loadCurrentPageUser(this.currentPage, 8, this.searchInput);
        this.dialogFormVisible = false;
      },
      //搜索用户
      search() {
        this.searchInput = this.input;
        this.getStudentByStudentNo(1, 8, this.searchInput);
      },
      //添加用户
      addUser() {
        this.dialogTitle = "添加用户";
        this.userInfo = {};
        this.dialogFormVisible = true;
      },
      getGenderSelected(){
        this.userInfo.gender = this.userInfo.gender;
      }
    }
  };
</script>

<style scoped>
  .user-table {
    width: 90%;
    min-width: 900px;
    margin: 0 auto;
    margin-bottom: 30px;
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
</style>
