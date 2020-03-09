<template>
  <div id="user-manage">
    <!--搜索-->
    <div class="top">
      <el-col :span="2" :offset="1">
        <el-button type="primary" size="small" @click="back">返回</el-button>
      </el-col>
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
        <el-button type="primary" size="small" @click="">座位详情页面</el-button>
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
          prop="student_name"
        ></el-table-column>
        <el-table-column label="学院" align="center" width="120" prop="faculty"></el-table-column>
        <el-table-column label="专业" align="center" width="120" prop="major"></el-table-column>
        <el-table-column label="行" align="center" width="100" prop="seat_x"></el-table-column>
        <el-table-column label="列" align="center" width="100" prop="seat_y"></el-table-column>
        <el-table-column label="选座码" align="center" width="100" prop="ticket_code"></el-table-column>
        <el-table-column label="操作" align="center" width="200">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleDetail(scope.$index, scope.row)">详情</el-button>
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
              <el-input v-model="userInfo.student_no" disabled></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="姓名" prop="student_name">
            <el-col :span="16">
              <!--              {{userInfo.student_name}}-->
              <el-input v-model="userInfo.student_name" disabled></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="照片">
            <el-col :span="16">
              <img
                :src="userInfo.avatar?userInfo.avatar:server+'/images/avatar/monkey.png'"
                ref="previewImg"
                alt
                width="80px"
                height="80px"
              />
            </el-col>
          </el-form-item>
          <el-form-item label="年级" prop="grade">
            <el-col :span="16">
              <el-input v-model="userInfo.grade" disabled></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="学院" prop="faculty">
            <el-col :span="16">
              <el-input v-model="userInfo.faculty" disabled></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="专业" prop="major">
            <el-col :span="16">
              <el-input v-model="userInfo.major" disabled></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="身份证号" prop="id_no">
            <el-col :span="16">
              <el-input v-model="userInfo.id_no" disabled=""></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="听课次数" prop="lectures_num">
            <el-col :span="16">
              <el-input v-model="userInfo.lectures_num" disabled></el-input>
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
    deleteStudentInfo, updateStudentInfo, addStudentInfo, getStudentByStudentNo, getCurrentPageLectureStudents
  } from "../../../api/index";
  import { MessageBox, Message } from "element-ui";
  import {confirmLectureStudentInfo, deleteLectureStudentInfo} from "../../../api";
  export default {
    name: "LectureStudentDetail",
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
        lectureStudentInfo:'',
        lectureInfo:'',
        lecture_id:''
      };
    },
    created() {
      this.lectureInfo = this.$route.params.lectureInfo;
      this.lecture_id = this.lectureInfo.lecture_id;
      this.loadCurrentPageLectureStudents(this.lecture_id,this.currentPage, 8, "");
    },
    methods: {
      async loadCurrentPageLectureStudents(lecture_id,currentPage, pageSize,input) {
        let json = await getCurrentPageLectureStudents(lecture_id,currentPage, pageSize,input);
        if (json.success_code === 200) {
          this.tableData = json.data;
          console.log(this.tableData);
          this.total = json.total;
        }
      },
      back(){
        this.$router.push({ name:'LectureManage',params:{} });
      },
      handleDetail(index,row){
        this.dialogTitle = "查看用户信息";
        this.userInfo = row;
        this.dialogFormVisible = true;
      },
      async handleConfirm(index,row){
        let json = await confirmLectureStudentInfo(row.lecture_id,row.student_id);
        if (json.success_code === 200){
          Message.success("成功");
        }
        else {
          Message.error("失败");
        }
      },
      handleDelete(index, row) {
        MessageBox.confirm(
          "此操作将永久删除姓名为"+row.student_name+"的学生的此次讲座的信息, 是否继续？",
          "提示",{
            type:'warning'
          }
        ).then(async value => {
          if (value === "confirm") {
            let json = await deleteLectureStudentInfo(row.lecture_id,row.student_id,row.seat_id);
            if (json.success_code === 200) {
              Message.success("删除该学生成功！");
              this.loadCurrentPageLectureStudents(this.lecture_id,this.currentPage, 8, "");
            }
            else {
              Message.error("删除失败");
            }
          }
        });
        console.log(index, row);
      },
      async currentChange(currentPage) {
        this.currentPage = currentPage;
        this.loadCurrentPageLectureStudents(this.lecture_id,this.currentPage, 8, this.searchInput);
      },
      cancel() {
        this.loadCurrentPageLectureStudents(this.lecture_id,this.currentPage, 8, this.searchInput);
        this.dialogFormVisible = false;
      },
      //搜索用户
      search() {
        this.searchInput = this.input;
        this.loadCurrentPageLectureStudents(this.lecture_id,1, 8, this.searchInput);
      },
      //添加用户
      addUser() {
        this.dialogTitle = "添加用户";
        this.userInfo = {};
        this.dialogFormVisible = true;
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
