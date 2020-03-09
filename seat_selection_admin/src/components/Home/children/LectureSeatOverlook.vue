<template>
  <el-container>
    <div class="back">
      <el-button icon="el-icon-back" circle @click="back"></el-button>
      <el-button icon="el-icon-full-screen" circle @click="handleFullScreen"></el-button>
    </div>

    <el-aside>
      <controller-aside2
        @markSeats="markSeats"
        @clearSeat="clearSeat"
        @confirm="confirm"
        :prop_x="seat_x"
        :prop_y="seat_y"
        :prop_lectureId="lecture_id"
        :prop_lectureName="lecture_name"
        :prop_lectureClassroom="lecture_classroom"
        :prop_lectureSelectedNum="lecture_selected_num"
      />
    </el-aside>

    <el-main>
      <coordinate-system2 ref="coordinateSystem2"
                         :prop_x="seat_x"
                         :prop_y="seat_y"
                         :prop_lectureId="lecture_id"
                         :prop_seatList="seatList"/>
    </el-main>
  </el-container>
</template>






<script>
    import {mapActions, mapState, mapMutations} from 'vuex'
    import ControllerAside2 from "./seatOverlookComponents/ControllerAside2";
    import CoordinateSystem2 from "./seatOverlookComponents/CoordinateSystem2";


    export default {
        name: 'LectureSeatOverlook',
        components: {
            ControllerAside2,
            CoordinateSystem2
        },
        props: {},
        watch: {},
        data() {
            return {
                lectureInfo: '',
                lecture_id: '',
                lecture_name: '',
                lecture_classroom: '',
                seat_x: '',
                seat_y: '',
                lecture_selected_num:'',
                seatList: [],
            }
        },
        // 做监听计算
        computed: {

            // 全屏切换
            ...mapState({
                fullscreen: state => state.config.fullscreen,
                x: state => state.lectureSeat.x,
                y: state => state.lectureSeat.y,
            }),


            // 取最大横坐标
            xMax: function () {
                let i = 0;
                for (let index in this.seatList) {
                    if (this.seatList[index].x > i) {
                        i = this.seatList[index].x
                    }
                }
                return i
            },


            // 取最大纵坐标
            yMax: function () {
                let i = 0;
                for (let index in this.seatList) {
                    if (this.seatList[index].y > i) {
                        i = this.seatList[index].y
                    }
                }
                return i
            }
        },

        methods: {

            // 全屏
            ...mapMutations([
                'makeFullscreen'
            ]),


            // 变换xy宽高
            ...mapMutations([
                'changeX',
                'changeY',
            ]),


            // 清除
            ...mapActions([
                'clearLectureSeat'
            ]),

            // 标记座位
            markSeats(e) {
                this.$refs.coordinateSystem2.markSeats(e)
            },

            // 清除座位
            clearSeat() {
                this.$refs.coordinateSystem2.clearSeat()
            },

            // 确定座位
            confirm() {
                this.$refs.coordinateSystem2.confirm()
            },


            // 返回
            back() {
                this.$router.push({path: "/home/lecture_manage"});
            },



            // 全屏
            handleFullScreen() {
                let element = document.documentElement;
                if (this.fullscreen) {
                    if (document.exitFullscreen) {
                        document.exitFullscreen()
                    } else if (document.webkitCancelFullScreen) {
                        document.webkitCancelFullScreen()
                    } else if (document.mozCancelFullScreen) {
                        document.mozCancelFullScreen()
                    } else if (document.msExitFullscreen) {
                        document.msExitFullscreen()
                    }
                    this.$message({
                        showClose: true,
                        message: '已退出全屏模式',
                        type: 'success'
                    })
                } else {
                    if (element.requestFullscreen) {
                        element.requestFullscreen()
                    } else if (element.webkitRequestFullScreen) {
                        element.webkitRequestFullScreen()
                    } else if (element.mozRequestFullScreen) {
                        element.mozRequestFullScreen()
                    } else if (element.msRequestFullscreen) {
                        // IE11
                        element.msRequestFullscreen()
                    }
                    this.$message({
                        showClose: true,
                        message: '已进入全屏幕模式,如需退出请按ESC按键或再次点击',
                        type: 'success'
                    })
                }
                this.makeFullscreen(!this.fullscreen)
            }
        },


        // created:在模板渲染成html前调用，即通常初始化某些属性值，然后再渲染成视图
        created() {
        },



        // mounted:在模板渲染成html后调用，通常是初始化页面完成后，再对html的dom节点进行一些需要的操作
        mounted() {
            console.log("this.$route.params.lectureInfo----", this.$route.params.lectureInfo);
            this.lectureInfo = this.$route.params.lectureInfo;
            this.lecture_id = this.lectureInfo.lecture_id;
            this.lecture_name = this.lectureInfo.title;
            this.lecture_classroom = this.lectureInfo.building + this.lectureInfo.location;
            this.seat_x = this.lectureInfo.row_num;
            this.seat_y = this.lectureInfo.column_num;
            this.lecture_selected_num = this.lectureInfo.seats_selected_num;
        },


        // 离开之前清除座位
        beforeRouteLeave(to, from, next) {
            this.clearLectureSeat().then(() => {
                next()
            })
        }
    }
</script>







<style lang="stylus" scoped>
  .el-container
    color rgba(0, 0, 0, 0.4)

    .back
      position absolute
      left 320px
      top 20px

    .el-main
      background-color: #E9EEF3;
      text-align: center;
      padding 0;

    .el-aside
      height 100vh;
      text-align: center;
</style>
