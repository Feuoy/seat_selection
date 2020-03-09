<template>
  <div id="lecture-manage">
    <!--搜索-->
    <div class="top">
      <el-col :span="12">
        <el-input placeholder="请输入讲座标题" v-model="input" class="input-with-select" style="width: 100%">
          <el-button slot="append" icon="el-icon-search" @click="search">搜索</el-button>
        </el-input>
      </el-col>
      <el-col :span="2" :offset="1">
        <el-button type="primary" size="small" @click="addLecture">添加讲座</el-button>
      </el-col>
    </div>
    <!--表格-->
    <div class="lecture-table">
      <el-table
        border
        :data="tableData">
        <el-table-column
          label="讲座标题"
          align="center"
          width="100"
          prop="title">
        </el-table-column>
        <el-table-column
          label="讲座教师"
          align="center"
          width="100"
          prop="teacher">
        </el-table-column>
        <el-table-column
          label="教学楼"
          align="center"
          width="100"
          prop="building">
        </el-table-column>
        <el-table-column
          label="位置"
          align="center"
          width="100"
          prop="location">
        </el-table-column>
        <el-table-column
          label="座位数"
          align="center"
          width="100"
          prop="total_seats_num">
        </el-table-column>
        <el-table-column
          label="已选座位数"
          align="center"
          width="100"
          prop="seats_selected_num">
        </el-table-column>
        <el-table-column
          label="开始时间"
          prop="start_time">
        </el-table-column>
        <el-table-column
          label="结束时间"
          prop="end_time">
        </el-table-column>
        <el-table-column
          align="center"
          width="400"
          label="操作">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="primary"
              @click="handleFinish(scope.$index, scope.row)">查看学生信息</el-button>
            <el-button
              size="mini"
              @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
            <el-button
              size="mini"
              @click="handleFinish2(scope.$index, scope.row)">查看座位情况</el-button>
            <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)">删除</el-button>
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
        :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<script>
  import {MessageBox,Message} from 'element-ui'
  import {getCurrentPageLecture} from "../../../api/index";
  import {addLectureInfo, deleteLectureInfo, updateLectureInfo} from "../../../api";
  import {upLoadLecturePosterImg} from "../../../api/index";
  import {dateFormat} from "../../../common/util/util";
  export default {
    name: "LectureManage",
    data() {
      return {
        //服务器地址
        server:'http://localhost:8081',
        tableData:[],
        total:0,
        currentPage:1,
        lectureInfo:{},
        dialogFormVisible:false,
        dialogTitle:'',
        labelPosition:'right',
        input:'',
        searchInput:'',
      }
    },
    created(){
      this.loadCurrentPageLecture(this.currentPage,6,'');
    },
    methods: {
      async loadCurrentPageLecture(currentPage,pageSize,input){
        let json = await getCurrentPageLecture(currentPage,pageSize,input);
        if (json.success_code===200){
          this.tableData = json.data;
          console.log(this.tableData);
          this.total = json.total;
        }
        for (let i = 0; i < this.tableData.length; i++) {
          this.tableData[i].start_time = dateFormat("YYYY-mm-dd HH:MM:SS",this.tableData[i].start_time);
          this.tableData[i].end_time = dateFormat("YYYY-mm-dd HH:MM:SS",this.tableData[i].end_time);
          this.tableData[i].application_deadline = dateFormat("YYYY-mm-dd HH:MM:SS",this.tableData[i].application_deadline);
        }
      },
      async currentChange(currentPage){
        this.currentPage = currentPage;
        this.loadCurrentPageLecture(this.currentPage,6,this.searchInput);
      },
      handleDetail(index,row){
        this.lectureInfo = row;
        this.$router.push({ name:'LectureStudentDetail',params:{lectureInfo:this.lectureInfo} });
      },
      handleFinish(index,row){
        this.lectureInfo = row;
        this.$router.push({ name:'CheckLectureStudent',params:{lectureInfo:this.lectureInfo} });
      },
      handleFinish2(index,row){
        this.lectureInfo = row;
        this.$router.push({ name:'LectureSeatOverlook',params:{lectureInfo:this.lectureInfo} });
      },
      handleEdit(index, row) {
        this.dialogTitle = '编辑讲座信息';
        this.lectureInfo = row;
        this.$router.push({ name:'EditLectureInfo',params:{lectureInfo:this.lectureInfo,dialogTitle:this.dialogTitle} });
        console.log(index, row);
      },
      async handleDelete(index, row) {
        console.log(index, row);
        MessageBox.confirm('此操作将永久删除'+row.title+'的讲座所有信息, 是否继续？','提示',{
          type:'warning'
        }).then(async (value)=>{
          if (value==='confirm'){
            let json = await deleteLectureInfo(row.lecture_id);
            if (json.success_code===200){
              this.loadCurrentPageLecture(this.currentPage,6,this.searchInput);
              Message.success('删除该讲座成功！');
            }
          }
        });
      },
      //搜索讲座
      search(){
        this.searchInput = this.input;
        this.loadCurrentPageLecture(1,6,this.searchInput);
      },
      //添加讲座
      addLecture(){
        this.dialogTitle = '添加讲座';
        this.lectureInfo = {};
        // this.dialogFormVisible = true;
        this.lectureInfo.title = '';
        this.lectureInfo.teacher = '';
        this.lectureInfo.introduction = '';
        this.lectureInfo.image = '';
        this.lectureInfo.classroom_id = '';
        this.lectureInfo.start_time = '';
        this.lectureInfo.end_time = '';
        this.lectureInfo.total_seats_num = '';
        this.lectureInfo.seats_selected_num = '';
        this.lectureInfo.application_deadline = '';
        this.$router.push({ name:'EditLectureInfo',params:{lectureInfo:this.lectureInfo,dialogTitle:this.dialogTitle} });
      },
      cancel(){
        this.dialogFormVisible = false;
        this.loadCurrentPageLecture(this.currentPage,6,this.searchInput);
      }
    },
  }
</script>

<style>
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
