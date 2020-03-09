<template>
  <div id="order-list">

    <!--搜索-->
    <div class="top">
      <el-col :span="12">
        <el-input placeholder="请输入内容" v-model="input" class="input-with-select" style="width: 100%">
          <el-button slot="append" icon="el-icon-search" @click="search"></el-button>
        </el-input>
      </el-col>
      <el-col :span="2" :offset="1">
      </el-col>
    </div>

    <!--表格-->
    <div class="order-table">
      <el-table
        :row-class-name="tableRowClassName"
        border
        :data="tableData">

        <el-table-column
          label="序号"
          align="center"
          width="70">
          <template slot-scope="scope">
            {{scope.$index + 1}}
          </template>
        </el-table-column>

        <el-table-column
          label="讲题"
          align="center"
          width="190"
          prop="title">
        </el-table-column>

        <el-table-column
          label="地点"
          align="center"
          width="120"
          prop="place"
          :formatter="format_place">
        </el-table-column>

        <el-table-column
          sortable
          label="时间"
          align="center"
          width="230"
          prop="start_end_time"
          :formatter="format_start_end_time">
        </el-table-column>

        <el-table-column
          label="座位"
          align="center"
          width="100"
          prop="seat_xy"
          :formatter="format_seat_location">
        </el-table-column>

        <el-table-column
          label="取票码"
          align="center"
          width="90"
          prop="ticket_code">
        </el-table-column>

        <el-table-column
          label="退约截止时间"
          align="center"
          width="170"
          prop="application_deadline"
          :formatter="format_application_deadline">
        </el-table-column>

        <el-table-column
          label="考核状态"
          align="center"
          width="130"
          prop="status">
        </el-table-column>

        <el-table-column
          width="210"
          align="center"
          label="操作">

          <template slot-scope="scope">

            <el-button
              size="mini"
              type="primary"
              icon="el-icon-document" circle

              @click="handleDetail(scope.$index, scope.row)"
            >
            </el-button>

            <el-button
              v-if="new Date() < new Date(scope.row.application_deadline)"
              size="mini"
              type="danger"
              icon="el-icon-delete" circle
              @click="handleDelete(scope.$index, scope.row)"
            >
            </el-button>

            <el-button
              v-if="new Date() > new Date(scope.row.application_deadline)"
              size="mini"
              type="info"
              icon="el-icon-delete" circle disabled
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

    <!--详情对话框-->
    <div>
      <el-dialog
        :title="dialogTitle"
        :visible.sync="dialogFormVisible"
        :modal-append-to-body="false"
        v-if="dialogFormVisible"
        :showClose="false"
      >

        <el-form :label-position="labelPosition" label-width="100px" :model="orderInfo">

          <!--讲座封面-->
          <el-form-item label="" prop="image">
            <el-col :span="16">
              <img :src="orderInfo.image" ref="previewImg" alt="" width="150px" height="200px">
            </el-col>
          </el-form-item>

          <el-form-item label="讲座题目" prop="title">
            <el-col :span="16">
              <el-tag type="primary">{{orderInfo.title}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="主讲教师" prop="teacher">
            <el-col :span="16">
              <el-tag type="primary">{{orderInfo.teacher}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="简介" prop="introduction">
            <el-col :span="16">
              <el-tag type="primary">{{orderInfo.introduction}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="教学楼" prop="building">
            <el-col :span="16">
              <el-tag type="primary">{{orderInfo.building}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="课室" prop="location">
            <el-col :span="16">
              <el-tag type="primary">{{orderInfo.location}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="开始时间" prop="start_time">
            <el-col :span="16">
              <el-tag type="primary">
                {{formatDetailTime(orderInfo.start_time)}}
              </el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="结束时间" prop="end_time">
            <el-col :span="16">
              <el-tag type="primary">
                {{formatDetailTime(orderInfo.end_time)}}
              </el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="总座位数" prop="total_seats_num">
            <el-col :span="16">
              <el-tag type="primary">{{orderInfo.total_seats_num}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="已选座位数" prop="seats_selected_num">
            <el-col :span="25">
              <el-tag type="primary">{{orderInfo.seats_selected_num}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="报名截止时间" prop="application_deadline">
            <el-col :span="25">
              <el-tag type="primary">
                {{formatDetailTime(orderInfo.application_deadline)}}
              </el-tag>
            </el-col>
          </el-form-item>

        </el-form>

        <div slot="footer" class="dialog-footer" style="align:center"></div>

      </el-dialog>
    </div>

  </div>
</template>

<script>
    import {MessageBox, Message} from 'element-ui'
    import {
        getStudentInfo,
        getCurrentPageOrder,
        readStudentLectureStatus,
        deleteOrderUpdateSeat,
        deleteOrderUpdateLecture,
        deleteOrderUpdateOperation,
        deleteOrderUpdateRecord,
    } from '../../../api/index'
    import {dateFormat, formatTheLastHour} from "../../../common/util/util";

    export default {
        name: "OrderList",

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

                orderInfo: {},
                studentInfo: {},
            }
        },

        created() {
            this.loadStudentInfo();
            this.loadCurrentPageOrder(this.currentPage, 8, '');
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

            // 获取已预约讲座
            async loadCurrentPageOrder(currentPage, pageSize, input) {
                let temp_table;
                let json = await getCurrentPageOrder(this.$cookies.get("student_id"), currentPage, pageSize, input);
                if (json.success_code === 200) {
                    temp_table = json.data;
                    this.total = json.total;
                }
                // 获取已预约讲座考核状态
                let lecture_id_s = [];
                for (let i = 0; i < temp_table.length; i++) {
                    let a = {};
                    a['id'] = temp_table[i].lecture_id;
                    lecture_id_s.push(a);
                }
                for (let i = 0; i < lecture_id_s.length; i++) {
                    let json_2 = await readStudentLectureStatus(this.$cookies.get("student_id"), lecture_id_s[i].id);
                    if (json_2.success_code === 200) {
                        temp_table[i].status = json_2.theStatus;
                    }
                }
                this.tableData = temp_table;
            },

            // 获取分页已预约讲座
            async currentChange(currentPage) {
                this.currentPage = currentPage;
                this.loadCurrentPageOrder(this.currentPage, 8, this.searchInput);
            },

            // 详情
            handleDetail(index, row) {
                this.dialogTitle = '讲座详情';
                this.orderInfo = row;
                this.dialogFormVisible = true;
            },

            // 搜索讲座
            search() {
                this.searchInput = this.input;
                this.loadCurrentPageOrder(1, 8, this.searchInput);
            },

            // 取消预约
            async handleDelete(index, row) {
                let json_1, json_2, json_3, json_4;
                json_1 = await deleteOrderUpdateSeat(row.lecture_id, row.seat_x, row.seat_y);
                json_2 = await deleteOrderUpdateLecture(row.lecture_id);
                json_3 = await deleteOrderUpdateOperation(this.$cookies.get("student_id"), row.lecture_id);
                json_4 = await deleteOrderUpdateRecord(this.$cookies.get("student_id"), row.lecture_id);
                if (json_1.success_code === 200
                    && json_2.success_code === 200
                    && json_3.success_code === 200
                    && json_4.success_code === 200) {
                    Message.success("取消成功！");
                    this.loadCurrentPageOrder(this.currentPage, 8, '');
                } else {
                    Message.error("取消失败！");
                }
            },

            /*------------------------------------------------------------------------------------------------*/

            // 单个详情日期
            formatDetailTime(time) {
                return dateFormat("YYYY年mm月dd日HH时MM分", time)
            },

            // 单个日期
            format_application_deadline(row) {
                return dateFormat("YYYY-mm-dd HH:MM", row.application_deadline)
            },

            // 范围日期
            format_start_end_time(row) {
                return dateFormat("YYYY-mm-dd HH:MM", row.start_time) + "~" + formatTheLastHour(row.end_time);
            },

            // 地点
            format_place(row) {
                return row.building + " " + row.location;
            },

            // 座位
            format_seat_location(row) {
                return row.seat_y + "排" + row.seat_x + "座";
            },

            // 表格行不同颜色
            tableRowClassName({row, rowIndex}) {
                if (rowIndex % 2 !== 0) {
                    return 'warning-row';
                } else {
                    return 'success-row';
                }
            },

        },
    }
</script>


<style>
  .el-table .warning-row {
    background: rgba(253, 245, 230, 0.61);
  }

  .el-table .success-row {
    background: rgba(240, 249, 235, 0.61);
  }

  .order-table {
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
