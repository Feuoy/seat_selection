<template>
    <div id="classroom-manage">
      <!--搜索-->
      <div class="top">
        <el-col :span="12">
          <el-input placeholder="请输入教室" v-model="input" class="input-with-select" style="width: 100%">
            <el-button slot="append" icon="el-icon-search" @click="search">搜索</el-button>
          </el-input>
        </el-col>
        <el-col :span="2" :offset="1">
          <el-button type="primary" size="small" @click="addClassroom">添加教室</el-button>
        </el-col>
      </div>
      <!--表格-->
      <div class="classroom-table">
        <el-table
          border
          :data="tableData"
          >
          <el-table-column
            label="教学楼"
            align="center"
            width="100"
            prop="building">
          </el-table-column>
          <el-table-column
            label="位置"
            show-overflow-tooltip
            prop="location">
          </el-table-column>
          <el-table-column
            label="教室的行数"
            align="center"
            width="120"
            prop="row_num">
          </el-table-column>
          <el-table-column
            label="教室的列数"
            align="center"
            width="120"
            prop="column_num">
          </el-table-column>
          <el-table-column
            label="座位数"
            show-overflow-tooltip
            prop="capacity">
          </el-table-column>
          <el-table-column
          width="200"
          align="center"
          label="操作">
            <template slot-scope="scope">
              <el-button
                size="mini"
                @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
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
      <!--弹框-->
      <div>
        <el-dialog
          :title="dialogTitle"
          :visible.sync="dialogFormVisible"
          :modal-append-to-body="false"
          v-if="dialogFormVisible"
          :showClose="false"
        >
          <el-form :label-position="labelPosition" label-width="80px" :model="classroomInfo" >
            <el-form-item label="教学楼" prop="building">
              <el-col :span="18">
                <el-input v-model="classroomInfo.building"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="位置" prop="location">
              <el-col :span="18">
                <el-input v-model="classroomInfo.location"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="行" prop="row_num">
              <el-col :span="18">
                <el-input v-model="classroomInfo.row_num"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="列" prop="column_num">
              <el-col :span="18">
                <el-input v-model="classroomInfo.column_num"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="座位数" prop="capacity">
              <el-col :span="18">
                <el-input v-model="classroomInfo.capacity"></el-input>
              </el-col>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="cancel">取 消</el-button>
            <el-button type="primary" @click="manageClassroomInfo()">确 定</el-button>
          </div>
        </el-dialog>
      </div>
    </div>
</template>

<script>
    import {MessageBox,Message} from 'element-ui'
    import {
      getCurrentPageClassroom, updateClassroomInfo, addClassroomInfo, deleteClassroomInfo
    } from '../../../api'
    export default {
        name: "ClassroomManage",
        data() {
          let checkPhone = (rule, value, callback) => {
            if (!value) {
              callback(new Error('请输入手机号码'));
            } else {
              if (/^1[3|4|5|6|7|8][0-9]{9}$/.test(value)){
                callback();
              } else{
                callback(new Error('请输入正确格式的手机号码'));
              }
            }
          };
          return {
            //服务器地址
            server:'http://localhost:8081',
            tableData:[],
            total:0,
            currentPage:1,
            classroomInfo:{},
            dialogFormVisible:false,
            dialogTitle:'',
            labelPosition:'right',
            input:'',
            searchInput:'',
            // rules: {
            //   cinema_name: [
            //     { required: true, message: '影院名不能为空', trigger: 'blur' },
            //   ],
            //   cinema_phone: [
            //     { required: true, message: '影院电话不能为空', trigger: 'blur' },
            //     { validator: checkPhone, trigger: 'blur' }
            //   ],
            //   specified_address: [
            //     { required: true, message: '影院地址不能为空', trigger: 'blur' },
            //   ]
            // },
          }
        },
        created(){
          this.loadCurrentPageClassroom(this.currentPage,8,'');
        },
        methods: {
          async loadCurrentPageClassroom(currentPage,pageSize,input){
            let json = await getCurrentPageClassroom(currentPage,pageSize,input);
            if (json.success_code===200){
              this.tableData = json.data;
              this.total = json.total;
            }
          },
          handleEdit(index, row) {
            this.dialogTitle = '编辑教室信息';
            this.classroomInfo = row;
            this.dialogFormVisible = true;
            console.log(index, row);
          },
          handleDelete(index, row) {
            console.log(index, row);
            MessageBox.confirm('此操作将永久删除'+row.building+row.location+'教室的所有信息, 是否继续？','提示',{
              type:'warning'
            }).then(async (value)=>{
              if (value==='confirm'){
                let json = await deleteClassroomInfo(row.classroom_id);
                if (json.success_code===200){
                  Message.success('删除该教室成功！');
                  this.loadCurrentPageClassroom(this.currentPage,8,this.searchInput);
                }
              }
            });
            console.log(index, row);
          },
          //修改教室信息
          async manageClassroomInfo(){
            if (!this.classroomInfo.building||!this.classroomInfo.location) {
              Message.error('请完成必填内容！');
            } else{
                if (this.dialogTitle==='编辑教室信息') {
                  let json = await updateClassroomInfo(this.classroomInfo.classroom_id,this.classroomInfo.building,this.classroomInfo.location,this.classroomInfo.row_num,this.classroomInfo.column_num,this.classroomInfo.capacity);
                  if (json.success_code===200){
                    this.dialogFormVisible = false;
                    Message.success('修改教室信息成功！');
                  } else if (json.error_code===1){
                    Message.error(json.message);
                  }
                } else{
                  let json = await addClassroomInfo(this.classroomInfo.building,this.classroomInfo.location,this.classroomInfo.row_num,this.classroomInfo.column_num,this.classroomInfo.capacity);
                  if (json.success_code===200){
                    this.loadCurrentPageClassroom(this.currentPage,8,this.searchInput);
                    this.dialogFormVisible = false;
                    Message.success('添加教室成功！');
                  } else if (json.error_code===1){
                    Message.error(json.message);
                  }
                }
            }
          },
          async currentChange(currentPage){
            this.currentPage = currentPage;
            this.loadCurrentPageClassroom(this.currentPage,8,this.searchInput);
          },
          //搜索教室
          search(){
            this.searchInput = this.input;
            this.loadCurrentPageClassroom(1,8,this.searchInput);
          },
          //添加教室
          addClassroom(){
            this.dialogTitle = '添加教室';
            this.classroomInfo = {};
            this.dialogFormVisible = true;
            this.loadCurrentPageClassroom(this.currentPage,8,this.searchInput);
          },
          cancel(){
            this.loadCurrentPageClassroom(this.currentPage,8,this.searchInput);
            this.dialogFormVisible = false;
          }
        },
    }
</script>

<style>
  .classroom-table{
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
    width: 80%;
    padding-left: 20%;
  }
</style>
