<template>
  <el-main id="edit-lectureInfo">
  <el-form ref="form" :model="lectureInfo" label-width="100px">
    <el-form-item label="讲座名称">
      <el-input v-model="lectureInfo.title" @input="change($event)"></el-input>
    </el-form-item>
    <el-form-item label="讲座教师">
      <el-input v-model="lectureInfo.teacher" @input="change($event)"></el-input>
    </el-form-item>
    <el-form-item label="海报" prop="image">
    <el-col :span="16">
      <img :src="lectureInfo.image ? lectureInfo.image: server+'/images/avatar/admin/postImage/bnuz.jpg'" ref="previewImg" alt="" width="150px" height="200px">
      <div style="position: relative;height: 64px">
        <el-button size="small" type="primary" style="position: absolute;left: 0;top: 0;cursor: pointer">点击上传</el-button>
        <input type="file" id="file" name="file" ref="uploadImg" accept="image/png, image/jpeg, image/gif, image/jpg" style="position: absolute;left: 0;top: 0;opacity: 0;height: 32px;width: 80px;cursor: pointer" @change="changeImg">
        <div slot="tip" class="el-upload__tip" style="position: absolute;left: 0;top: 32px;height: 32px">只能上传jpg/png文件，且不超过500kb</div>
      </div>
    </el-col>
  </el-form-item>
    <el-form-item label="讲座介绍">
      <el-input type="textarea" v-model="lectureInfo.introduction" @input="change($event)"></el-input>
    </el-form-item>

    <el-form-item label="讲座位置">
      <el-cascader
        :options="options"
        v-model="selectedOptions"
        @change="handleChange">
      </el-cascader>
      <el-button @click="addClassroom">如左边选项框中没有想要的教室，请点击此处添加教室</el-button>
    </el-form-item>

    <el-form-item label="讲座时间">
      <el-date-picker
        v-model="date"
        type="datetimerange"
        range-separator="至"
        start-placeholder="开始日期"
        end-placeholder="结束日期">
      </el-date-picker>
    </el-form-item>

    <el-form-item label="截止时间">
      <el-date-picker
        v-model="application_deadline"
        type="datetime"
        placeholder="选择日期时间"
        @input="change($event)">
      </el-date-picker>
    </el-form-item>

    <el-form-item label="座位数">
      <el-input v-model="lectureInfo.total_seats_num" @input="change($event)" disabled></el-input>
    </el-form-item>

    <el-form-item label="已选座位数">
      <el-input v-model="lectureInfo.seats_selected_num" @input="change($event)" disabled></el-input>
    </el-form-item>

    <el-form-item>
      <el-button type="primary" @click="onSubmit">{{this.type === "添加讲座" ? "添加" : "修改"}}</el-button>
      <el-button @click="onBack">取消</el-button>
      <el-button type="primary" @click="toSeat()" v-if="isShowed">座位排布</el-button>
    </el-form-item>
  </el-form>
    <div style="height: auto"></div>
    <!--弹框-->
    <div>
      <el-dialog
        :title="dialogTitle"
        :visible.sync="dialogFormVisible"
        :modal-append-to-body="false"
        v-if="dialogFormVisible"
        :showClose="false"
      >
        <el-form :label-position="labelPosition" label-width="80px" :rules="rules">
          <el-form-item label="教学楼" prop="building">
            <el-col :span="18">
              <el-input v-model="building"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="位置" prop="location">
            <el-col :span="18">
              <el-input v-model="location"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="行" prop="row_num">
            <el-col :span="18">
              <el-input v-model="row_num"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="列" prop="column_num">
            <el-col :span="18">
              <el-input v-model="column_num"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="座位数" prop="capacity">
            <el-col :span="18">
              <el-input v-model="capacity" @input="change($event)"></el-input>
            </el-col>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="cancel">取 消</el-button>
          <el-button type="primary" @click="manageClassroomInfo()">确 定</el-button>
        </div>
      </el-dialog>
    </div>
  </el-main>



</template>

<script>
  import {dateFormat} from "../../../common/util/util";
  import {
    addClassroomInfo,
    addLectureInfo,
    getClassroomBuilding,
    getClassroomByBuilding, getClassroomByBuildingAndLocation, getClassroomById, getLectureInfoById,
    updateLectureInfo,
    upLoadLecturePosterImg
  } from "../../../api";
  import {MessageBox,Message} from 'element-ui'
  export default {
      name: "EditLectureInfo",
      data() {
        return {
          server:'http://localhost:8081',
          date:'',
          lectureInfo:'',
          // title:'',
          // teacher:'',
          // introduction:'',
          // image:'',
          // classroom_id:'',
          start_time : '',
          end_time : '',
          // total_seats_num:'',
          // seats_selected_num:'',
          // application_deadline:'',
          selectedOptions:'',
          buildingInfo:'',
          temp_classroomInfo:'',
          building:'',
          location:'',
          capacity:'',
          row_num:'',
          column_num:'',
          selectedClassroom:'',
          dialogFormVisible:false,
          dialogTitle:'添加教室',
          application_deadline:'',
          isShowed:false,
          options: [{
            value: '请选择',
            label: '请选择',
            children: [{
              value: '请选择',
              label: '请选择'
            }]
          }]
        }
      },
      created(){
        this.lectureInfo = this.$route.params.lectureInfo;
        this.type = this.$route.params.dialogTitle;
        console.log("lectureInfo json:"+JSON.stringify(this.lectureInfo));
        if (this.lectureInfo.title!==""){
          this.lectureInfo.start_time = dateFormat("YYYY-mm-dd HH:MM:SS",this.lectureInfo.start_time);
          this.lectureInfo.end_time = dateFormat("YYYY-mm-dd HH:MM:SS",this.lectureInfo.end_time);
          this.start_time = dateFormat("YYYY-mm-dd HH:MM:SS",this.lectureInfo.start_time);
          this.end_time = dateFormat("YYYY-mm-dd HH:MM:SS",this.lectureInfo.end_time);
          // this.lectureInfo.application_deadline = dateFormat("YYYY-mm-dd HH:MM:SS",this.lectureInfo.application_deadline);
          this.date = [new Date(this.start_time),new Date(this.end_time)];
          this.selectedOptions = [this.lectureInfo.building,this.lectureInfo.classroom_id];
          this.application_deadline = this.lectureInfo.application_deadline;
          this.isShowed = true; //显示座位排布按钮
        }
        else {
          this.lectureInfo.seats_selected_num = 0;
        }
        // else {
        //   this.lectureInfo.application_deadline = dateFormat("YYYY-mm-dd HH:MM:SS",new Date());
        // }
        // this.title = this.lectureInfo.title,
        // this.teacher = this.lectureInfo.teacher,
        // this.introduction = this.lectureInfo.introduction,
        // this.image = this.lectureInfo.image,
        // this.classroom_id = this.lectureInfo.classroom_id,
        // this.total_seats_num = this.lectureInfo.total_seats_num,
        this.loadBuildingInfo(); //加载教学楼信息
      },
      methods: {
        onSubmit() {
          this.manageLectureInfo();
        },
        onBack(){
          this.$router.push({name:'LectureManage'});
        },
        changeImg(e){
          let reader = new FileReader();
          reader.readAsDataURL(this.$refs.uploadImg.files[0]);//发起异步请求
          let _this = this;
          reader.onload = function(){
            //读取完成后，将结果赋值给img的src
            _this.$refs.previewImg.src = this.result;
            _this.lectureInfo.image = this.result;
          }
        },
        cancel(){
          this.dialogFormVisible = false;
        },
        addClassroom(){
          this.dialogFormVisible = true;
        },
        async handleChange(value) {
          // console.log("aaaaaaaaaaaaaaaa:"+value[1]);
          this.lectureInfo.classroom_id = value[1];
          let json = await getClassroomById(this.lectureInfo.classroom_id);
          if (json.success_code===200){
            this.temp_classroomInfo = json.data;
            this.lectureInfo.total_seats_num = this.temp_classroomInfo[0].capacity;
            console.log("this.capacity:"+ this.lectureInfo.total_seats_num);
          }
        },
        toSeat(){
          this.$router.push({ name:'LectureSeat',params:{lectureInfo:this.lectureInfo} });
        },
        async loadBuildingInfo(){
          let json = await getClassroomBuilding();
          if(json.success_code===200){
            this.buildingInfo = json.data;
            this.initOptions();
          }
        },
        async getClassroomInfoByBuilding(building){
          let json = await getClassroomByBuilding(building);
          if (json.success_code===200){
            this.temp_classroomInfo = json.data;
          }
        },
        //添加教室信息
        async manageClassroomInfo(){
          if (!this.building||!this.location) {
            Message.error('请完成必填内容！');
          } else{
              let json = await addClassroomInfo(this.building,this.location,this.row_num,this.column_num,this.capacity);
              if (json.success_code===200){
                await this.loadBuildingInfo();
                await this.searchClassroomInfoByBuildingAndLocation(this.building,this.location);
                this.selectedOptions = [this.selectedClassroom[0].building,this.selectedClassroom[0].classroom_id];
                this.lectureInfo.classroom_id = json.id;
                this.dialogFormVisible = false;
                Message.success('添加教室成功！');
              } else if (json.error_code===1){
                Message.error(json.message);
              }
            }
          }
        ,
        async searchClassroomInfoByBuildingAndLocation(building,location){
          let json = await getClassroomByBuildingAndLocation(building,location);
          if(json.success_code===200){
            this.selectedClassroom = json.data;
          }
        },
        async initOptions(){
          let str = new Array();
          for (let i = 0; i < this.buildingInfo.length; i++) {
            let a = {};
            a['value'] = this.buildingInfo[i].building;
            a['label'] = this.buildingInfo[i].building;
            await this.getClassroomInfoByBuilding(this.buildingInfo[i].building);
            let classList = this.temp_classroomInfo;
            let children = new Array();
            for (let j = 0; j < classList.length; j++) {
              let b = {};
              b['value'] = classList[j].classroom_id;
              b['label'] = classList[j].location;
              children.push(b);
            }
            a['children'] = children;
            str.push(a);
          }
          str = JSON.stringify(str);
          this.options = JSON.parse(str);
        },
        async getLectureInfoById(lectureId){
          let json = await getLectureInfoById(lectureId);
          if(json.success_code===200){
            this.lectureInfo = json.data;
          }
        },
        //修改讲座信息
        async manageLectureInfo(){
          // console.log("aaa");
          if (this.lectureInfo.title) {
            let formData = new FormData();
            formData.append('file',this.$refs.uploadImg.files[0]);
            let json = await upLoadLecturePosterImg(formData);
            if (json.success_code===200){
              if (json.data.length){
                this.lectureInfo.image = '/images/avatar/admin/postImage/'+json.data[0].filename;
              }
              if (this.type === '编辑讲座信息') {
                this.lectureInfo.application_deadline = dateFormat("YYYY-mm-dd HH:MM:SS",new Date(this.application_deadline));
                console.log("application_deadline:" + this.application_deadline);
                this.lectureInfo.start_time = dateFormat("YYYY-mm-dd HH:MM:SS",this.date[0]);
                this.lectureInfo.end_time = dateFormat("YYYY-mm-dd HH:MM:SS",this.date[1]);
                json = await updateLectureInfo(this.lectureInfo.lecture_id,this.lectureInfo.title,this.lectureInfo.teacher,this.lectureInfo.introduction,this.lectureInfo.image,this.lectureInfo.classroom_id,this.lectureInfo.start_time,this.lectureInfo.end_time,this.lectureInfo.total_seats_num,this.lectureInfo.seats_selected_num,this.lectureInfo.application_deadline);
                if (json.success_code===200){
                  Message.success('修改讲座信息成功！');
                  // this.$router.push({ name:'LectureSeat',params:{lectureInfo:this.lectureInfo} });
                } else if (json.error_code===1){
                  Message.error(json.message);
                }
              } else{
                this.lectureInfo.application_deadline = dateFormat("YYYY-mm-dd HH:MM:SS",this.application_deadline);
                this.lectureInfo.start_time = dateFormat("YYYY-mm-dd HH:MM:SS",this.date[0]);
                this.lectureInfo.end_time = dateFormat("YYYY-mm-dd HH:MM:SS",this.date[1]);
                json = await addLectureInfo(this.lectureInfo.title,this.lectureInfo.teacher,this.lectureInfo.introduction,this.lectureInfo.image,this.lectureInfo.classroom_id,this.lectureInfo.start_time,this.lectureInfo.end_time,this.lectureInfo.total_seats_num,this.lectureInfo.seats_selected_num,this.lectureInfo.application_deadline);
                if (json.success_code===200){
                  Message.success('添加讲座成功！');
                  let lectureId = json.lecture_id;
                  await this.getLectureInfoById(lectureId);
                  console.log("lectureInfo:"  + this.lectureInfo);
                  this.$router.push({ name:'LectureSeat',params:{lectureInfo:this.lectureInfo} });
                } else if (json.error_code===1){
                  Message.error(json.message);
                }
              }
            }
          } else{
            Message.error('请完成必填内容！');
          }
        },
        change (e) {
          this.$forceUpdate();
        }
      }
    }
</script>

<style scoped>

</style>
