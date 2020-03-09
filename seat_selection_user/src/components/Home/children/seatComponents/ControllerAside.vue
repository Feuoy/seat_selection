<template>

  <div class="pages" ref="contentScroll">

    <div class="scroll">

      <el-timeline>

        <el-timeline-item timestamp="第一步" placement="top" size='large' color="#C6E2FF">
          <el-card>

            <div slot="header">
              <span>讲座信息</span>
            </div>

            <el-form label-position="left" label-width="60px">

              <el-form-item label="讲座">
                <el-tag type="success">{{lecture_name}}</el-tag>
              </el-form-item>

              <el-form-item label="教室">
                <el-tag type="success">{{lecture_classroom}}</el-tag>
              </el-form-item>

            </el-form>

          </el-card>
        </el-timeline-item>

        <el-timeline-item timestamp="第二步" border-radius="border-radius" placement="top" size='large' color="#C6E2FF">
          <el-card>

            <div slot="header">
                <span>
                选择听众
                </span>
            </div>

            <el-row>
              <el-col :span="12">
                <div>
                  <el-checkbox label="自己" v-model="checkForm.checkList"
                               style="width: 170px; margin-top: 10px; margin-left: 3px" border disabled></el-checkbox>
                  <el-checkbox-group v-model="checkForm.checkList" @change="handleChecked">
                    <el-checkbox
                      v-for="(item,i) in options"
                      :key="i"
                      :label="item.label"
                      :value="item.value"
                      style="width: 170px; margin-top: 10px; margin-left: 3px"
                      border>
                    </el-checkbox>
                  </el-checkbox-group>
                </div>
              </el-col>
            </el-row>

            <el-row>
              <el-col :span="12">

                <div v-if="options_cannotSelect[0]" style="text-align: center; width: 180px; margin-top: 40px">
                  <p>以下好友已预约</p>
                  <el-divider></el-divider>
                </div>

                <div>
                  <el-checkbox-group v-model="checkForm_cannotSelect.checkList" @change="handleChecked">
                    <el-checkbox
                      v-for="(item,i) in options_cannotSelect"
                      :key="i"
                      :label="item.label"
                      :value="item.value"
                      style="width: 170px; margin-top: 10px; margin-left: 3px"
                      border disabled>
                    </el-checkbox>
                  </el-checkbox-group>
                </div>
              </el-col>
            </el-row>

          </el-card>
        </el-timeline-item>

        <el-timeline-item timestamp="第三步" placement="top" size='large' color="#C6E2FF">
          <el-card>

            <div slot="header">
                <span>
                选择座位（框选或点选）
                </span>
            </div>

            <el-row>

              <el-col :span="10">
                <div class="seatButton" @click="markSeats('normal')">
                  选中
                  <img class="seat-demo" src="../../../../common/image/seat_can.png"/>
                </div>
              </el-col>

              <el-col :span="2">
                &nbsp;
              </el-col>

              <el-col :span="10">
                <div class="seatButton" style="text-align: center" @click="clearSeat">
                  重置
                  <img class="seat-demo" src="../../../../common/image/seat_0.png"/>
                </div>
              </el-col>

            </el-row>

          </el-card>
        </el-timeline-item>

        <el-timeline-item timestamp="第四步" placement="top" size='large' color="#C6E2FF">
          <el-card>
            <el-row>

              <el-col :span="24">
                <el-popover
                  placement="top"
                  width="160"
                  v-model="visible2">

                  <p>确认完成？</p>

                  <div style="text-align: right; margin: 0">
                    <el-button size="mini" type="text" @click="visible2 = false">取消</el-button>
                    <el-button type="primary" size="mini" @click="confirm()">确定</el-button>
                  </div>

                  <el-button style="width: 170px;" :loading="confirmButtonLoading" slot="reference" size="small" round
                             type="primary">完成
                  </el-button>

                </el-popover>
              </el-col>

            </el-row>
          </el-card>
        </el-timeline-item>

      </el-timeline>

    </div>

  </div>

</template>

<script>
    import BScroll from 'better-scroll'
    import {mapMutations, mapState} from 'vuex'
    import {
        getCurrentPageRelationship,
        findLectureByStudentId
    } from '../../../../api/index'

    export default {
        name: 'ControllerAside',

        components: {},

        props: [
            'prop_x',
            'prop_y',
            'prop_lectureId',
            'prop_lectureName',
            'prop_lectureClassroom',
        ],

        data() {
            return {
                visible: false,
                visible2: false,

                max: 35,
                x: 0,
                y: 0,

                marks: {
                    10: '10',
                    20: '20',
                    30: {
                        style: {
                            color: '#1989FA'
                        },
                        label: this.$createElement('strong', '30')
                    }
                },

                lecture_name: '',
                lecture_id: '',
                lecture_classroom: '',

                // 复选框内容
                options: {},
                options_cannotSelect: {},
                value: '',

                // 复选框选择的内容
                checkForm: {
                    checkList: ["自己"]
                },
                checkForm_cannotSelect: {
                    checkList: []
                },

                // 可选好友列表
                relationshipInfo: {},
                // 不可选好友列表
                relationshipInfo_cannotSelect: {},

                theStudentId: this.$cookies.get("student_id"),
                theLectureId: this.$cookies.get("theLectureId"),
            }
        },

        watch: {
            prop_x(value) {
                this.x = value
            },

            prop_y(value) {
                this.y = value
            },

            prop_lectureName(value) {
                this.lecture_name = value;
            },

            prop_lectureId(value) {
                this.lecture_id = value;
            },

            prop_lectureClassroom(value) {
                this.lecture_classroom = value;
            },
        },

        computed: {
            ...mapState({
                confirmButtonLoading: state => state.lectureSeat.confirmButtonLoading
            }),
        },

        created() {
            this.loadCurrentPageRelationship(1, 8, '');
            this.pre_handleChecked();
            this.handleChecked();
        },

        mounted() {
            this.$nextTick(() => {
                if (!this.scroll) {
                    this.scroll = new BScroll(this.$refs.contentScroll, {
                            scrollbar: {
                                fade: true,
                                interactive: false
                            },
                            mouseWheel: {
                                speed: 20,
                                invert: false,
                                easeTime: 300
                            },
                            scroll: true,
                            click: true
                        }
                    )
                } else {
                    this.scroll.refresh()
                }
            })
        },

        methods: {

            ...mapMutations([
                'changeX',
                'changeY',
                'changeConfirmButtonLoading',
                'changeReset'
            ]),

            handleChangeX() {
                this.changeX(this.x);
                this.changeReset(true)
            },

            handleChangeY() {
                this.changeY(this.y);
                this.changeReset(true)
            },

            markSeats(e) {
                this.$emit('markSeats', e)
            },

            clearSeat() {
                this.changeReset(true);
                this.visible = false;
                this.$emit('clearSeat');
            },

            confirm() {
                this.visible2 = false;
                this.changeConfirmButtonLoading(true);
                this.$emit('confirm');
            },

            /*----------------------------------------------------------------------------*/

            // 加载所有好友
            async loadCurrentPageRelationship(currentPage, pageSize, input) {
                let json = await getCurrentPageRelationship(this.theStudentId, currentPage, pageSize, input);
                if (json.success_code === 200) {
                    this.relationshipInfo = json.data;
                    this.init_Options_AND_Options_cannotSelect();
                }
            },

            // 处理可选好友、不可选好友
            async init_Options_AND_Options_cannotSelect() {
                // 先判断不可选好友
                let friendsAndSelf_cannotSelect = [];
                for (let i = 0; i < this.relationshipInfo.length; i++) {
                    let b = {};
                    let json = await findLectureByStudentId(this.relationshipInfo[i].student_id, this.theLectureId);
                    // console.log("status_code----", json.status_code);
                    if (json.status_code !== 200) {
                        b['id'] = this.relationshipInfo[i].student_id;
                        b['name'] = this.relationshipInfo[i].student_name;
                    }
                    if (b['id']) {
                        friendsAndSelf_cannotSelect.push(b);
                    }
                }
                // console.log("friendsAndSelf_cannotSelect----", friendsAndSelf_cannotSelect);
                this.relationshipInfo_cannotSelect = friendsAndSelf_cannotSelect;
                let str = [];
                for (let i = 0; i < this.relationshipInfo_cannotSelect.length; i++) {
                    let a = {};
                    a['value'] = this.relationshipInfo_cannotSelect[i].name;
                    a['label'] = this.relationshipInfo_cannotSelect[i].name;
                    str.push(a);
                }
                this.options_cannotSelect = str;
                /*------------------------------------------------------------------------------------*/
                // 再过滤可选好友
                // console.log("initOptions--this.relationshipInfo_cannotSelect----", this.relationshipInfo_cannotSelect);
                let str2 = [];
                for (let i = 0; i < this.relationshipInfo.length; i++) {
                    let a = {};
                    let isSelect = false;
                    for (let j = 0; j < this.relationshipInfo_cannotSelect.length; j++) {
                        if (this.relationshipInfo[i].student_id == this.relationshipInfo_cannotSelect[j].id) {
                            isSelect = true;
                            break;
                        }
                    }
                    if (isSelect == false) {
                        a['value'] = this.relationshipInfo[i].student_name;
                        a['label'] = this.relationshipInfo[i].student_name;
                        str2.push(a);
                    }
                }
                // console.log("initOptions--", str2);
                this.options = str2;
            },

            // 没有点击选好友，默认自己
            pre_handleChecked() {
                // console.log("pre_handleChecked----this.checkForm.checkList----", this.checkForm.checkList);
                let friendsAndSelf = [];
                let a = {};
                a['id'] = parseInt(this.$cookies.get("student_id"));
                friendsAndSelf.push(a);
                // console.log("pre_handleChecked----", friendsAndSelf);
                this.$cookies.set("friendsAndSelf", JSON.stringify(friendsAndSelf));
            },

            // 点击了选好友
            async handleChecked() {
                // console.log("this.checkForm.checkList----", this.checkForm.checkList);
                let friendsAndSelf = [];
                let friendsAndSelf_cannotSelect = [];
                let a = {};
                a['id'] = parseInt(this.$cookies.get("student_id"));
                friendsAndSelf.push(a);
                for (let i = 1; i < this.checkForm.checkList.length; i++) {
                    let a = {};
                    for (let j = 0; j < this.relationshipInfo.length; j++) {
                        if (this.checkForm.checkList[i] == this.relationshipInfo[j].student_name) {
                            // console.log("one_cannotSelect----", this.relationshipInfo[j].student_id);
                            let json = await findLectureByStudentId(this.relationshipInfo[j].student_id, this.theLectureId);
                            // console.log("status_code----", json.status_code);
                            if (json.status_code === 200) {
                                a['id'] = this.relationshipInfo[j].student_id;
                            }
                        }
                    }
                    if (a['id']) {
                        friendsAndSelf.push(a);
                    }
                }
                // console.log("friendsAndSelf----", friendsAndSelf);
                this.$cookies.set("friendsAndSelf", JSON.stringify(friendsAndSelf));
                // console.log("friendsAndSelf_cannotSelect----", friendsAndSelf_cannotSelect);
                this.$cookies.set("friendsAndSelf_cannotSelect", JSON.stringify(friendsAndSelf_cannotSelect));
            },

        }
    }
</script>


<style lang="stylus" scoped>
  .pages
    box-sizing: border-box;
    padding: 30px 10px;
    overflow: hidden
    position relative
    height 100vh

    .scroll
      padding-top 15px

      .seat-demo
        width 20px
        height 20px
        vertical-align -65%

      .seatButton
        display flex
        align-items center
        justify-content space-between
        padding 6px 8px
        color #409EFF
        font-size 12px
        background #ecf5ff
        border 1px #b3d8ff solid
        border-radius 5px
        cursor pointer

        .seatText
          text-align: center
          width: 100%
</style>
