<template>
  <div id="relationship-list">

    <!--搜索-->
    <div class="top">
      <el-col :span="12">
        <el-input placeholder="请输入内容" v-model="input" class="input-with-select" style="width: 100%">
          <el-button slot="append" icon="el-icon-search" @click="search"></el-button>
        </el-input>
      </el-col>
    </div>

    <!--表格-->
    <div class="relationship-table">
      <el-table
        border
        :data="tableData">

        <el-table-column
          label="序号"
          align="center"
          width="130">
          <template slot-scope="scope">
            {{scope.$index + 1}}
          </template>
        </el-table-column>

        <el-table-column
          label="学号"
          align="center"
          width="180"
          prop="student_no">
        </el-table-column>

        <el-table-column
          label="姓名"
          align="center"
          width="200"
          prop="student_name">
        </el-table-column>

        <el-table-column
          label="性别"
          align="center"
          width="110"
          prop="gender"
          :formatter="formatGender">
        </el-table-column>

        <el-table-column
          label="年级"
          align="center"
          width="110"
          prop="grade">
        </el-table-column>

        <el-table-column
          label="学院"
          align="center"
          width="150"
          prop="faculty">
        </el-table-column>

        <el-table-column
          label="专业"
          align="center"
          width="240"
          prop="major">
        </el-table-column>

        <el-table-column
          width="190"
          align="center"
          label="操作">

          <!--表头，添加好友-->
          <template slot="header" slot-scope="scope">
            <el-button
              type="primary" plain
              size="small"
              icon="el-icon-circle-plus-outline"
              @click="addFellow">
            </el-button>
          </template>

          <!--每行，删除好友-->
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="danger"
              icon="el-icon-delete" circle
              @click="handleDelete(scope.$index, scope.row)"
            >
            </el-button>
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

    <!--添加好友对话框-->
    <div>
      <el-dialog
        :title="dialogTitle"
        :visible.sync="dialogFormVisible"
        :modal-append-to-body="false"
        v-if="dialogFormVisible"
        :showClose="false"
      >

        <el-form :label-position="labelPosition" label-width="100px" :model="fellowInfo">

          <el-form-item label="好友 · 学号" prop="fellow_student_no">
            <el-col :span="16">
              <el-input v-model="fellowInfo.fellow_student_no"></el-input>
            </el-col>
          </el-form-item>

          <el-form-item label="好友 · 好友码" prop="fellow_student_friend_code">
            <el-col :span="16">
              <el-input v-model="fellowInfo.fellow_student_friend_code"></el-input>
            </el-col>
          </el-form-item>

        </el-form>

        <div slot="footer" class="dialog-footer">

          <el-button @click="cancel">
            <i class="el-icon-close el-icon--right"></i>
          </el-button>

          <el-button type="primary" @click="manageFellowInfo()">
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
        deleteRelationship,
        getCurrentPageRelationship,
        addRelationship,
    } from '../../../api/index'

    export default {
        name: "RelationshipList",

        data() {
            return {
                server: 'http://localhost:8081',

                tableData: [],
                total: 0,
                currentPage: 1,

                input: '',
                searchInput: '',

                labelPosition: 'right',
                dialogFormVisible: false,
                dialogTitle: '',

                studentInfo: {},
                relationshipInfo: {},
                fellowInfo: {},

                theStudentId: this.$cookies.get("student_id"),
            }
        },

        created() {
            this.loadStudentInfo();
            this.loadCurrentPageRelationship(this.currentPage, 8, '');
        },

        methods: {

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

            // 获取好友
            async loadCurrentPageRelationship(currentPage, pageSize, input) {
                let json = await getCurrentPageRelationship(this.theStudentId, currentPage, pageSize, input);
                if (json.success_code === 200) {
                    this.tableData = json.data;
                    this.total = json.total;
                }
            },

            // 获取分页好友
            async currentChange(currentPage) {
                this.currentPage = currentPage;
                this.loadCurrentPageRelationship(this.currentPage, 8, this.searchInput);
            },

            // 详情
            handleDetail(index, row) {
                this.dialogTitle = '讲座详情';
                this.relationshipInfo = row;
                this.dialogFormVisible = true;
            },

            //删除好友
            async handleDelete(index, row) {
                let json = await deleteRelationship(this.studentInfo.student_id, row.fellow_student_id);
                if (json.success_code === 200) {
                    this.loadCurrentPageRelationship(this.currentPage, 8, '');
                    Message.success("删除成功！");
                } else {
                    Message.warning(json.message);
                }
            },

            // 添加好友
            async manageFellowInfo() {
                if (this.fellowInfo.fellow_student_no && this.fellowInfo.fellow_student_friend_code) {
                    if (this.fellowInfo.fellow_student_no == this.studentInfo.student_no) {
                        Message.error('不可以添加自己为好友！');
                    } else {
                        let json = await addRelationship(this.theStudentId, this.fellowInfo.fellow_student_no, this.fellowInfo.fellow_student_friend_code);
                        if (json.success_code === 200) {
                            this.loadCurrentPageRelationship(this.currentPage, 8, this.searchInput);
                            this.dialogFormVisible = false;
                            Message.success('添加好友成功！');
                        } else if (json.error_code === 1) {
                            Message.error(json.message);
                        }
                    }
                } else {
                    Message.error('请完成必填内容！');
                }
            },

            //搜索好友
            search() {
                this.searchInput = this.input;
                this.loadCurrentPageRelationship(1, 8, this.searchInput);
            },

            // 添加好友对话框
            addFellow() {
                this.dialogTitle = '添加好友';
                this.fellowInfo = {};
                this.dialogFormVisible = true;
            },

            // 添加好友对话框的返回
            cancel() {
                this.dialogFormVisible = false;
                this.loadCurrentPageRelationship(this.currentPage, 8, this.searchInput);
            },

            // 性别转换
            formatGender: function (row) {
                return row.gender == '1' ? "男" : row.gender == '0' ? "女" : "";
            },

        },
    }
</script>


<style>
  .relationship-table {
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
