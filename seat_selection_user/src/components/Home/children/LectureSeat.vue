<template>

  <el-container>

    <!-- 返回 -->
    <div class="back">
      <el-button icon="el-icon-back" circle @click="back"></el-button>
      <el-button icon="el-icon-full-screen" circle @click="handleFullScreen"></el-button>
    </div>

    <!-- 左侧 -->
    <el-aside>
      <controller-aside
        @markSeats="markSeats"
        @clearSeat="clearSeat"
        @confirm="confirm"
        :prop_x="seat_x"
        :prop_y="seat_y"
        :prop_lectureId="lecture_id"
        :prop_lectureName="lecture_name"
        :prop_lectureClassroom="lecture_classroom"
      />
    </el-aside>

    <!-- 右侧 -->
    <el-main>
      <coordinate-system ref="coordinateSystem"
                         :prop_x="seat_x"
                         :prop_y="seat_y"
                         :prop_lectureId="lecture_id"
                         :prop_seatList="seatList"/>
    </el-main>

  </el-container>

</template>

<script>
    import {mapActions, mapState, mapMutations} from 'vuex'
    import ControllerAside from "./seatComponents/ControllerAside";
    import CoordinateSystem from "./seatComponents/CoordinateSystem";

    export default {
        name: 'LectureSeat',

        components: {
            ControllerAside,
            CoordinateSystem
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
            },

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
                this.$refs.coordinateSystem.markSeats(e)
            },

            // 清除座位
            clearSeat() {
                this.$refs.coordinateSystem.clearSeat()
            },

            // 确定座位
            confirm() {
                this.$refs.coordinateSystem.confirm()
            },

            // 返回
            back() {
                this.$router.push({path: "/home/lecture_list"});
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

        created() {
        },

        mounted() {
            this.lectureInfo = this.$route.params.lectureInfo;
            this.lecture_id = this.lectureInfo.lecture_id;
            this.lecture_name = this.lectureInfo.title;
            this.lecture_classroom = this.lectureInfo.building + this.lectureInfo.location;
            this.seat_x = this.lectureInfo.row_num;
            this.seat_y = this.lectureInfo.column_num;
        },

        beforeRouteLeave(to, from, next) {
            this.clearLectureSeat().then(() => {
                next()
            })
        },

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
