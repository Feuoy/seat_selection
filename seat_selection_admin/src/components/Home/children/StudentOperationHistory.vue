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
    </div>
    <!--表格-->
    <el-main>

    </el-main>
    <div class="user-table">
      <el-table border :data="tableData">
        <el-table-column label="讲座" align="center" width="120" prop="title"></el-table-column>
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
        <el-table-column label="操作类型" align="center" width="60">
          <template slot-scope="scope">
            {{ scope.row.operation_type === 0 ? '选座':'退选'}}
          </template>
        </el-table-column>
        <el-table-column label="操作对象" align="center" width="60">
          <template slot-scope="scope">
            {{ scope.row.object === 1 ? '管理员':'学生'}}
          </template>
        </el-table-column>
        <el-table-column label="操作时间" align="center" width="120" prop="operation_time"></el-table-column>
        <el-table-column show-overflow-tooltip label="操作" align="center">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleDetail(scope.$index, scope.row)">个人信息</el-button>
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
          <el-form-item label="密码" prop="student_password">
            <el-col :span="16">
              <el-input v-model="userInfo.student_password" show-password disabled></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="身份证号" prop="id_no">
            <el-col :span="16">
              <el-input v-model="userInfo.id_no" disabled></el-input>
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
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
  import {deleteStudentInfo, getStudentOperationList} from "../../../api";
    import { MessageBox, Message } from "element-ui";
  import {dateFormat} from "../../../common/util/util";

    export default {
        name: "StudentOperationHistory",
        data(){
          return{
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
          }
        },
        created() {
          this.loadCurrentPageStudentOperation(this.currentPage, 6, "");

        },
        methods: {
          async loadCurrentPageStudentOperation(currentPage, pageSize,input) {
            let json = await getStudentOperationList(currentPage, pageSize,input);
            if (json.success_code === 200) {
              this.tableData = json.data;
              this.total = json.total;
              for (let i = 0; i < this.tableData.length; i++) {
                this.tableData[i].operation_time = dateFormat("YYYY-mm-dd HH:MM:SS",this.tableData[i].operation_time);
              }
            }
          },
          cancel(){
            this.dialogFormVisible = false;
          },
          handleDetail(index,row){
            this.dialogTitle = "查看用户信息";
            this.userInfo = row;
            this.dialogFormVisible = true;
          },
          handleStory(index,row){
            this.userInfo = row;
            this.$router.push({ name:'StudentLectureHistory',params:{userInfo:this.userInfo} });
          },
          async currentChange(currentPage) {
            this.currentPage = currentPage;
            this.loadCurrentPageStudentOperation(this.currentPage, 6, this.searchInput);
          },
          //搜索用户
          search() {
            this.searchInput = this.input;
            this.loadCurrentPageStudentOperation(1, 6, this.searchInput);
          }
        }
    }
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
