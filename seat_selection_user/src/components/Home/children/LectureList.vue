<template>
  <div id="lecture-list">

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
    <div class="lecture-table">
      <el-table
        :row-class-name="tableRowClassName"
        border
        :data="tableData">

        <!-- 宽度和：1240 -->
        <el-table-column
          label="序号"
          align="center"
          width="100">
          <template slot-scope="scope">
            {{scope.$index + 1}}
          </template>
        </el-table-column>

        <el-table-column
          label="讲座题目"
          align="center"
          width="210"
          prop="title">
        </el-table-column>

        <el-table-column
          label="主讲教师"
          align="center"
          width="110"
          prop="teacher">
        </el-table-column>

        <el-table-column
          label="地点"
          align="center"
          width="130"
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
          label="已选 / 总选"
          align="center"
          width="110"
          prop="choose_all_seat_num"
          :formatter="format_choose_all_seat_num">
        </el-table-column>

        <el-table-column
          label="报名截止时间"
          align="center"
          width="160"
          prop="application_deadline"
          :formatter="format_application_deadline">
        </el-table-column>

        <el-table-column
          width="260"
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
              size="mini"
              type="warning"
              icon="el-icon-star-off" circle
              @click="handleCollect(scope.$index, scope.row)"
            >
            </el-button>
            <el-button
              v-if="new Date() < new Date(scope.row.application_deadline)
              && scope.row.seats_selected_num < scope.row.total_seats_num"
              size="mini"
              type="success"
              icon="el-icon-position" circle
              @click="handleSubscribe(scope.$index, scope.row)"
            >
            </el-button>
            <el-button
              v-if="new Date() > new Date(scope.row.application_deadline)
              || scope.row.seats_selected_num >= scope.row.total_seats_num"
              size="mini"
              type="info"
              icon="el-icon-position" circle disabled
              @click="handleSubscribe(scope.$index, scope.row)"
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

    <!-- 详情对话框 -->
    <div>
      <el-dialog
        :title="dialogTitle"
        :visible.sync="dialogFormVisible"
        :modal-append-to-body="false"
        v-if="dialogFormVisible"
        :showClose="false"
      >

        <el-form :label-position="labelPosition" label-width="100px" :model="lectureInfo" :data="tableData">

          <!--讲座封面-->
          <el-form-item label="" prop="image">
            <el-col :span="16">
              <img :src="lectureInfo.image" ref="previewImg" alt="" width="150px" height="200px">
            </el-col>
          </el-form-item>

          <el-form-item label="讲座题目" prop="title">
            <el-col :span="16">
              <el-tag type="primary">{{lectureInfo.title}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="主讲教师" prop="teacher">
            <el-col :span="16">
              <el-tag type="primary">{{lectureInfo.teacher}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="简介" prop="introduction">
            <el-col :span="16">
              <el-tag type="primary">{{lectureInfo.introduction}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="教学楼" prop="building">
            <el-col :span="16">
              <el-tag type="primary">{{lectureInfo.building}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="课室" prop="location">
            <el-col :span="16">
              <el-tag type="primary">{{lectureInfo.location}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="开始时间" prop="start_time">
            <el-col :span="16">
              <el-tag type="primary">
                {{formatDetailTime(lectureInfo.start_time) }}
              </el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="结束时间" prop="end_time">
            <el-col :span="16">
              <el-tag type="primary">
                {{formatDetailTime(lectureInfo.end_time) }}
              </el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="总座位数" prop="total_seats_num">
            <el-col :span="16">
              <el-tag type="primary">{{lectureInfo.total_seats_num}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="已选座位数" prop="seats_selected_num">
            <el-col :span="25">
              <el-tag type="primary">{{lectureInfo.seats_selected_num}}</el-tag>
            </el-col>
          </el-form-item>

          <el-form-item label="报名截止时间" prop="application_deadline">
            <el-col :span="25">
              <el-tag type="primary">
                {{formatDetailTime(lectureInfo.application_deadline) }}
              </el-tag>
            </el-col>
          </el-form-item>

        </el-form>

        <!-- nothing -->
        <div slot="footer" class="dialog-footer" style="align:center"></div>

      </el-dialog>
    </div>

  </div>
</template>

<script>
    import {Message} from 'element-ui'
    import {
        addCollection,
        getCurrentPageLecture,
        getStudentInfo,
    } from '../../../api/index'
    import {dateFormat, formatTheLastHour} from "../../../common/util/util";

    export default {
        name: "LectureList",

        data() {
            return {
                server: 'http://localhost:8081',

                tableData: [],
                total: 0,
                currentPage: 1,

                input: '',
                searchInput: '',

                studentInfo: {},
                lectureInfo: {},

                labelPosition: 'right',
                dialogFormVisible: false,
                dialogTitle: '',
            }
        },

        created() {
            this.loadStudentInfo();
            this.loadCurrentPageLecture(this.currentPage, 8, '');
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

            // 获取讲座
            async loadCurrentPageLecture(currentPage, pageSize, input) {
                let json = await getCurrentPageLecture(currentPage, pageSize, input);
                if (json.success_code === 200) {
                    this.tableData = json.data;
                    this.total = json.total;
                }
            },

            // 获取分页讲座
            async currentChange(currentPage) {
                this.currentPage = currentPage;
                this.loadCurrentPageLecture(this.currentPage, 8, this.searchInput);
            },

            // 详情
            handleDetail(index, row) {
                this.dialogTitle = '讲座详情';
                this.lectureInfo = row;
                this.dialogFormVisible = true;
            },

            // 预约
            handleSubscribe(index, row) {
                this.$cookies.set("theLectureId", row.lecture_id);
                // 这个lectureInfo已经带了课室信息
                this.$router.push({name: 'LectureSeat', params: {lectureInfo: row}});
            },

            // 收藏
            async handleCollect(index, row) {
                let json = await addCollection(this.studentInfo.student_id, row.lecture_id);
                if (json.success_code === 200) {
                    Message.success("收藏成功！");
                } else {
                    Message.warning(json.message);
                }
            },

            //搜索讲座
            search() {
                this.searchInput = this.input;
                this.loadCurrentPageLecture(1, 8, this.searchInput);
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

            // 已选、可选座位数
            format_choose_all_seat_num(row) {
                return row.seats_selected_num + " / " + row.total_seats_num;
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

  .lecture-table {
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
