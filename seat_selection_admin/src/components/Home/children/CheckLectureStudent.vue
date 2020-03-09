<template>
  <el-tabs v-model="activeName" @tab-click="handleClick">
    <el-tab-pane label="全部学生" name="first">
      <div id="user-manage">
        <!--搜索-->
        <div class="top">
          <el-col :span="2" :offset="1">
            <el-button type="primary" size="small" @click="back">返回</el-button>
          </el-col>
          <el-col :span="12">
            <el-input
              placeholder="请输入学号"
              v-model="input1"
              class="input-with-select"
              clearable
              style="width: 100%"
            >
              <el-button slot="append" icon="el-icon-search" @click="search1">搜索</el-button>
            </el-input>
          </el-col>
          <el-col :span="2" :offset="1">
            <el-button type="primary" size="small" @click="confirmAll" v-if="isShowedBtnConfirmAll">确认全部学生合格</el-button>
          </el-col>
        </div>
        <!--表格-->
        <div class="user-table">
          <el-table border :data="tableData1">
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
        <div class="block" v-if="tableData1.length">
          <el-pagination
            @current-change="currentChange1"
            background
            layout="prev, pager, next"
            :page-size="8"
            :total="total1"
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
            </div>
          </el-dialog>
        </div>
      </div>
    </el-tab-pane>
    <el-tab-pane label="合格学生" name="second">
      <div class="user-table">

        <div class="top">
          <el-col :span="12">
            <el-input
              placeholder="请输入学号"
              v-model="input2"
              class="input-with-select"
              clearable
              style="width: 100%"
            >
              <el-button slot="append" icon="el-icon-search" @click="search2">搜索</el-button>
            </el-input>
          </el-col>
        </div>

        <el-table border :data="tableData2">
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
              <el-button size="mini" type="danger" @click="handleNotFinished(scope.$index, scope.row)">不合格</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <!--分页-->
      <div class="block" v-if="tableData2.length">
        <el-pagination
          @current-change="currentChange2"
          background
          layout="prev, pager, next"
          :page-size="8"
          :total="total2">
        </el-pagination>
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
          </div>
        </el-dialog>
      </div>
    </el-tab-pane>
    <el-tab-pane label="不合格学生" name="third">
      <div class="user-table">

        <div class="top">
          <el-col :span="12">
            <el-input
              placeholder="请输入学号"
              v-model="input3"
              class="input-with-select"
              clearable
              style="width: 100%"
            >
              <el-button slot="append" icon="el-icon-search" @click="search3">搜索</el-button>
            </el-input>
          </el-col>
        </div>

        <el-table border :data="tableData3">
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
              <el-button size="mini" type="primary" @click="handleConfirm(scope.$index, scope.row)">确认合格</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <!--分页-->
      <div class="block" v-if="tableData3.length">
        <el-pagination
          @current-change="currentChange3"
          background
          layout="prev, pager, next"
          :page-size="8"
          :total="total3">
        </el-pagination>
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
          </div>
        </el-dialog>
      </div>
    </el-tab-pane>
  </el-tabs>
</template>

<script>
    import { MessageBox, Message } from "element-ui";
    import {
      checkIsConfirmed,
      confirmLectureAllStudent,
      confirmLectureStudentInfo,
      deleteLectureStudentInfo,
      getCurrentPageLectureFinishedStudents, getCurrentPageLectureNotFinishedStudents,
      getCurrentPageLectureStudents, removeToNotFinishedStudent
    } from "../../../api";
    export default {
        name: "CheckLectureStudent",
        data() {
          return {
            activeName: 'first',
            server: "http://localhost:8081",
            tableData1: [],
            tableData2:[],
            tableData3:[],
            total1: 0,
            total2: 0,
            total3: 0,
            currentPage1: 1,
            currentPage2: 1,
            currentPage3: 1,
            userInfo: {},
            dialogFormVisible: false,
            dialogTitle: "",
            labelPosition: "right",
            input1: "",
            input2:'',
            input3:'',
            searchInput:'',
            lectureStudentInfo:'',
            lectureInfo:'',
            lecture_id:'',
            isShowedBtnConfirmAll:false
          };
        },
        created() {
          this.lectureInfo = this.$route.params.lectureInfo;
          this.lecture_id = this.lectureInfo.lecture_id;
          this.loadCurrentPageLectureStudents(this.lecture_id,this.currentPage1, 8, "");
          this.loadCurrentPageLectureFinishedStudents(this.lecture_id,this.currentPage2,8,"");
          this.loadCurrentPageLectureNotFinishedStudents(this.lecture_id,this.currentPage3,8,"");
          this.isShowBtn();
        },
        methods: {
          handleClick(tab, event) {
            this.loadCurrentPageLectureStudents(this.lecture_id,this.currentPage1, 8, "");
            this.loadCurrentPageLectureFinishedStudents(this.lecture_id,this.currentPage2,8,"");
            this.loadCurrentPageLectureNotFinishedStudents(this.lecture_id,this.currentPage3,8,"");
            this.isShowBtn();
            console.log(tab, event);
          },
          back(){
            this.$router.push({ name:'LectureManage',params:{} });
          },
          async confirmAll(){
            let json = await confirmLectureAllStudent(this.lecture_id);
            if (json.success_code === 200){
              Message.success("确认成功");
              this.loadCurrentPageLectureFinishedStudents(this.lecture_id,this.currentPage2,8,"");
              this.isShowBtn();
            }
          },
          async isShowBtn(){
            let json = await checkIsConfirmed(this.lecture_id);
            if (json.success_code === 1){
              this.isShowedBtnConfirmAll = true;
            } else{
              this.isShowedBtnConfirmAll = false;
            }
          },
          async loadCurrentPageLectureStudents(lecture_id,currentPage, pageSize,input) {
            let json = await getCurrentPageLectureStudents(lecture_id,currentPage, pageSize,input);
            if (json.success_code === 200) {
              this.tableData1 = json.data;
              console.log(this.tableData1);
              this.total1 = json.total;
            }
          },
          async loadCurrentPageLectureFinishedStudents(lecture_id,currentPage,pageSize,input){
            let json = await getCurrentPageLectureFinishedStudents(lecture_id,currentPage, pageSize,input);
            if (json.success_code === 200) {
              this.tableData2 = json.data;
              console.log(this.tableData2);
              this.total2 = json.total;
            }
          },
          async loadCurrentPageLectureNotFinishedStudents(lecture_id,currentPage,pageSize,input){
            let json = await getCurrentPageLectureNotFinishedStudents(lecture_id,currentPage, pageSize,input);
            if (json.success_code === 200) {
              this.tableData3 = json.data;
              console.log(this.tableData3);
              this.total3 = json.total;
            }
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
              this.loadCurrentPageLectureNotFinishedStudents(row.lecture_id,this.currentPage3,8,"");
              this.loadCurrentPageLectureFinishedStudents(row.lecture_id,this.currentPage2,8,"");
            }
            else {
              Message.error("失败");
            }
          },
          async handleNotFinished(index,row){
            let json = await removeToNotFinishedStudent(row.lecture_id,row.student_id);
            if (json.success_code === 200){
              Message.success("成功");
              this.loadCurrentPageLectureNotFinishedStudents(row.lecture_id,this.currentPage3,8,"");
              this.loadCurrentPageLectureFinishedStudents(row.lecture_id,this.currentPage2,8,"");
              this.isShowBtn();
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
                  this.loadCurrentPageLectureStudents(this.lecture_id,this.currentPage1, 8, "");
                }
                else {
                  Message.error("删除失败");
                }
              }
            });
            console.log(index, row);
          },
          async currentChange1(currentPage) {
            this.currentPage1 = currentPage;
            this.loadCurrentPageLectureStudents(this.lecture_id,this.currentPage1, 8, this.input1);
          },
          async currentChange2(currentPage) {
            this.currentPage2 = currentPage;
            this.loadCurrentPageLectureFinishedStudents(this.lecture_id,this.currentPage2, 8, this.input2);
          },
          async currentChange3(currentPage) {
            this.currentPage3 = currentPage;
            this.loadCurrentPageLectureNotFinishedStudents(this.lecture_id,this.currentPage3, 8, this.input3);
          },
          cancel() {
            this.loadCurrentPageLectureStudents(this.lecture_id,this.currentPage1, 8, this.input1);
            this.dialogFormVisible = false;
          },
          //搜索用户
          search1() {
            this.loadCurrentPageLectureStudents(this.lecture_id,1, 8, this.input1);
          },
          search2(){
            this.loadCurrentPageLectureFinishedStudents(this.lecture_id,1,8,this.input2);
          },
          search3(){
            this.loadCurrentPageLectureNotFinishedStudents(this.lecture_id,1,8,this.input3);
          }
        }
    }
</script>

<style scoped>
  .lecture-table{
    width:90%;
    min-width:900px;
    margin: 0 auto;
    margin-bottom: 30px;
  }
  .top{
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 30px 0;
    margin-bottom: 30px;
  }
  .block{
    text-align: center;
  }
  .el-dialog__header{
    text-align: center;
  }
  .el-dialog__body .el-form-item{
    padding-left: 20%;
  }
</style>
