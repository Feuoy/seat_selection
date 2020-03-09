<template>
  <el-container>
    <el-header>
      <el-button @click="back">返回</el-button>
      <p>{{numberInfo}}</p>
    </el-header>
    <el-main>
      <div class="block">

        <el-timeline>
          <el-timeline-item
            placement="top"
            v-for="(activity, index) in activities"
            :key="index"
            :timestamp="activity.timestamp">
            <el-card>
              <h4>{{activity.content}}</h4>
              <p>{{activity.timestamp ==='' ? '':'讲座时间'}}{{activity.timestamp}}</p>
            </el-card>

          </el-timeline-item>
        </el-timeline>
      </div>
    </el-main>
  </el-container>
</template>

<script>
    import {getStudentLectureHistory} from "../../../api";
    import {dateFormat} from "../../../common/util/util";

    export default {
        name: "StudentLectureHistory",
        data() {
          return {
            reverse: true,
            activities: [{
              content: '',
              timestamp: ''
            }],
            userInfo:'',
            lectureInfo:'',
            numberInfo:''
          };
        },
        created() {
          this.userInfo = this.$route.params.userInfo;
          this.searchHistory(this.userInfo.student_id);
        },
        methods: {
          async searchHistory(student_id) {
            let json = await getStudentLectureHistory(student_id);
            if (json.success_code === 200) {
              this.lectureInfo = json.data;
              this.initData(this.lectureInfo);
              this.numberInfo = this.userInfo.student_name + '共有' + this.lectureInfo.length + '次讲座记录';
            }
          },
          initData(lectureInfo){
            let temp = [];
            if (lectureInfo!==''){
              for (let i = 0; i < lectureInfo.length; i++) {
                let info = {};
                info.content = lectureInfo[i].title;
                info.timestamp = dateFormat("YYYY-mm-dd",lectureInfo[i].start_time);
                temp.push(info);
              }
              this.activities = temp;
            }
          },
          back(){
            this.$router.push({ name:'UserManage',params:{} });
          }
        }
    }
</script>

<style scoped>

</style>
