<template>
  <div class="pages" ref="contentScroll">
    <div class="scroll">
      <el-timeline>
        <el-timeline-item timestamp="讲座信息" placement="top" size='large' color="#C6E2FF">
          <el-card>
            <div slot="header">
              <span>讲座信息</span>
            </div>
            <el-form label-position="left" label-width="50px">
              <el-form-item label="讲座">
                <el-tag type="success">{{lecture_name}}</el-tag>
              </el-form-item>
              <el-form-item label="教室">
                <el-tag type="success">{{lecture_classroom}}</el-tag>
              </el-form-item>
              <el-form-item label="已选">
                <el-tag type="success">{{lecture_selected_num}}</el-tag>
              </el-form-item>
            </el-form>
          </el-card>
        </el-timeline-item>
      </el-timeline>
    </div>
  </div>
</template>

<script>
    import {MessageBox, Message} from 'element-ui'
    import BScroll from 'better-scroll'
    import {mapMutations, mapState} from 'vuex'
    export default {
        name: 'ControllerAside2',
        components: {},
        props: [
            'prop_x',
            'prop_y',
            'prop_lectureId',
            'prop_lectureName',
            'prop_lectureClassroom',
            'prop_lectureSelectedNum'
        ],
        data() {
            return {
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
                visible: false,
                visible2: false,
                lecture_name: '',
                lecture_id: '',
                lecture_classroom: '',
                options: {},
                value: '',
                checked1: true,
                checked2: false,
                checked3: false,
                checked4: true,
                checkboxGroup1: [],
                lecture_selected_num:''
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
            prop_lectureSelectedNum(value){
              this.lecture_selected_num = value;
              console.log("lecture_selected_num:" + this.lecture_selected_num);
            }
        },
        computed: {
            ...mapState({
                confirmButtonLoading: state => state.lectureSeat.confirmButtonLoading
            }),
        },
        created() {
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
            }
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
