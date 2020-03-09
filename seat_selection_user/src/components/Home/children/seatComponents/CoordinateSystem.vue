<template>

  <div class="pages"
       @mousedown.stop.prevent.left="start($event)"
       @mousemove.stop.prevent.left="drag($event)"
       @mouseup.stop.prevent.left="end($event)"
       @mouseleave.stop.prevent.left="fix($event)">

    <div class="seatSelectArea" ref="seatSelectArea">

      <div class="seatArea" :style="{width:seatAreaWidth+'px',height:seatAreaHeight+ 'px'}" v-show="x!==0 && y!==0">

        <template v-for="(seatItem,index) in seatList">

          <div ref="seatItem" :x="seatItem.x" :y="seatItem.y"
               class="seatItem"
               :key="'x'+seatItem.x+'y'+seatItem.y"
               :style="{width:seatItemWidth+'px',height:seatItemWidth+'px',
          transform: 'translate3d(' + seatItem.translateX  + 'px,'+ seatItem.translateY + 'px,0px)',
          background:seatItem.background}" @click="handleClick(index)">

            <img v-if="seatItem.backimg" :src="seatItem.backimg">

          </div>

        </template>

      </div>

    </div>

    <drag-div :left="left" :top="top" :width="width" :height="height" v-show="showDrag"></drag-div>

  </div>

</template>


<script>
    import {Message} from 'element-ui'
    import {mapMutations, mapActions, mapState} from 'vuex'
    import DragDiv from './DragDiv'
    import {
        getLectureClassroomIsSelected,
        findSeatId,
        selectSeatUpdateSeat,
        selectSeatUpdateLecture,
        selectSeatUpdateOperation,
        selectSeatUpdateRecord,
        findLectureByStudentId
    } from '../../../../api/index'

    export default {
        name: 'CoordinateSystem',

        components: {
            DragDiv
        },

        props: [
            'prop_x',
            'prop_y',
            'prop_seatList',
            'prop_lectureId'
        ],

        data() {
            return {
                seatItemWidth: 40,
                shifting: 10, // 偏移值
                left: 0,
                top: 0,
                width: 0,
                height: 0,
                startX: 0,
                startY: 0,

                showDrag: false,
                seatList: [],
                seatListBack: null,

                unSelect: '#C6E2FF',
                selecting: '#409EFF',
                selected: '#E9EEF3',
                timer: null,

                x: 0,
                y: 0,

                preserveImg: require('../../../../common/image/preserve_seat.png'),
                disableImg: require('../../../../common/image/seat_cannot.png'),
                normalImg: require('../../../../common/image/seat_can.png'),

                interfaceURL: 'http://localhost:8081',

                theStudentId: this.$cookies.get("student_id"),
                theLectureId: this.$cookies.get("theLectureId"),

                lecture_id: '',
                seatIsSelected: [],
            }
        },

        watch: {
            prop_seatList(value) {
                this.seatListBack = value;
            },

            prop_x(value) {
                this.x = value
                this.refreshDom()
            },

            prop_y(value) {
                this.y = value
                this.refreshDom()
            },

            prop_lectureId(value) {
                this.lecture_id = value
            }
        },

        computed: {
            ...mapState({
                reset: state => state.lectureSeat.reset
            }),

            seatAreaWidth() {
                return (this.seatItemWidth + this.shifting) * this.x - this.shifting
            },

            seatAreaHeight() {
                return (this.seatItemWidth + this.shifting) * this.y - this.shifting
            },

            translateValue() {
                return this.seatItemWidth + this.shifting
            },

            //选择座位
            selectingList() {
                let selectingList = [];
                for (const index in this.seatList) {
                    if (this.seatList[index].background === this.selecting) {
                        let temp = {...this.seatList[index]};
                        temp.orgIndex = index;
                        selectingList.push(temp)
                    }
                }
                var obj = {};
                for (let index in selectingList) {
                    let seatRowList = selectingList[index].y;
                    if (seatRowList in obj) {
                        obj[seatRowList].push(selectingList[index])
                    } else {
                        let seatArr = [];
                        seatArr.push(selectingList[index]);
                        obj[seatRowList] = seatArr
                    }
                }
                return obj;
            }
        },

        methods: {

            mounted() {
            },
            updated() {
            },
            created() {
            },

            ...mapMutations([
                'changeConfirmButtonLoading']),

            ...mapActions([
                'clearLectureSeat'
            ]),

            // 刷新dom
            refreshDom() {
                let that = this;
                let seatScale = 1;
                let seatScaleX = 1;
                let seatScaleY = 1;
                let seatSelectAreaWidth = that.$refs.seatSelectArea.offsetWidth;
                let seatSelectAreaHeight = that.$refs.seatSelectArea.offsetHeight;
                let seatAreaWidth = 50 * that.x - that.shifting;
                let seatAreaHeight = 50 * that.y - that.shifting;
                if (seatAreaWidth > seatSelectAreaWidth) {
                    seatScaleX = seatSelectAreaWidth / seatAreaWidth
                }
                if (seatAreaHeight > seatSelectAreaHeight) {
                    seatScaleY = seatSelectAreaHeight / seatAreaHeight
                }
                if (seatScaleX < 1 || seatScaleY < 1) {
                    seatScale = seatScaleX < seatScaleY ? seatScaleX : seatScaleY
                }
                that.seatItemWidth = 40 * seatScale
                that.shifting = 10 * seatScale
                that.seatList = []
                for (let x = 1; x <= that.x; x++) {
                    for (let y = 1; y <= that.y; y++) {
                        var data = {}
                        if (!that.reset && that.seatListBack != null && that.seatListBack.length > 0) {
                            let temp = that.seatListBack.find((el) => (el.x === x && el.y === y))
                            if (temp) {
                            debugger
                                let backimg = null
                                switch (temp.seat_type) {
                                    case '1':
                                        backimg = this.normalImg
                                        break
                                    case '2':
                                        backimg = this.preserveImg
                                        break
                                    default:
                                        backimg = this.normalImg
                                        break
                                }
                                data = {
                                    x: x,
                                    y: y,
                                    translateX: that.translateValue * (x - 1),
                                    translateY: that.translateValue * (y - 1),
                                    background: this.selected,
                                    backimg: backimg
                                }
                                that.seatList.push(data)
                                continue
                            }
                        }
                        data = {
                            x: x,
                            y: y,
                            translateX: that.translateValue * (x - 1),
                            translateY: that.translateValue * (y - 1),
                            background: this.unSelect,
                            backimg: null
                        }
                        that.seatList.push(data)
                    }
                }

                // 预选
                this.preSelect();

                this.$nextTick(() => {
                    if ('seatItem' in that.$refs) {
                        for (const item of that.$refs.seatItem) {
                            let clientRect = item.getBoundingClientRect()
                            let index = that.seatList.findIndex((el) => (el.x === parseInt(item.attributes.x.value) && el.y === parseInt(item.attributes.y.value)))
                            let newObject = Object.assign({}, that.seatList[index], {
                                top: clientRect.top,
                                bottom: clientRect.bottom,
                                left: clientRect.left,
                                right: clientRect.right
                            })
                            this.$set(that.seatList, index, newObject)
                        }
                    }
                })
            },

            // 开始
            start(e) {
                let that = this
                // 解决mousedown导致click失效
                if (that.timer) {
                    clearTimeout(that.timer)
                }
                that.timer = setTimeout(function () {
                    that.showDrag = true
                }, 100)
                let x = e.clientX
                let y = e.clientY
                that.left = x
                that.top = y
                that.startX = x
                that.startY = y
            },

            // 拖拉
            drag(e) {
                let that = this
                if (that.showDrag) {
                    let x = e.clientX
                    let y = e.clientY
                    that.left = Math.min(x, that.startX)
                    that.top = Math.min(y, that.startY)
                    that.width = Math.abs(x - that.startX)
                    that.height = Math.abs(y - that.startY)
                }
            },

            // 清零
            fix() {
                if (this.showDrag) {
                    let that = this
                    that.left = 0
                    that.top = 0
                    that.width = 0
                    that.height = 0
                    that.startX = 0
                    that.startY = 0
                    that.showDrag = false
                }
            },

            // 结束
            end() {
                clearTimeout(this.timer)
                if (this.showDrag) {
                    // 首先求出 `元素左上角` 与 `选框左上角` 在X方向较大值与Y方向较大值的交点，记为M点
                    // 然后求出 `元素右下角` 与` 选框右下角` 在X方向较小值与Y方向较小值的交点，记为N点。
                    // 如果M点的X坐标和Y坐标值均比N点相应的X坐标和Y坐标值小，亦即M和N可以分别构成一个矩形的左上角点和右上角点，则两矩形相交；其余情况则不相交。
                    let that = this
                    let seatList = that.seatList
                    let dragX0 = that.left
                    let dragY0 = that.top
                    let dragX1 = that.left + that.width
                    let dragY1 = that.top + that.height
                    for (const index in seatList) {
                        let mX = Math.max(dragX0, seatList[index].left)
                        let mY = Math.max(dragY0, seatList[index].top)
                        let nX = Math.min(dragX1, seatList[index].right)
                        let nY = Math.min(dragY1, seatList[index].bottom)
                        if (mX < nX && mY < nY) {
                            if (that.seatList[index].background === that.selecting) {
                                if (that.seatList[index].backimg === '' || that.seatList[index].backimg === null) {
                                    this.$set(that.seatList[index], 'background', that.unSelect)
                                } else {
                                    this.$set(that.seatList[index], 'background', that.selected)
                                }
                            } else if (that.seatList[index].background === that.unSelect) {
                                this.$set(that.seatList[index], 'background', that.selecting)
                            } else if (that.seatList[index].background === that.selected) {
                                this.$set(that.seatList[index], 'background', that.selecting)
                            }
                        }
                    }
                    that.left = 0
                    that.top = 0
                    that.width = 0
                    that.height = 0
                    that.startX = 0
                    that.startY = 0
                    that.showDrag = false
                }
            },

            /*--------------------------------------------------------------------------------------------------*/

            // 点击
            handleClick(index) {
                let that = this;
                if (that.seatList[index].background === that.selecting) {
                    if (that.seatList[index].backimg === '' || that.seatList[index].backimg === null) {
                        this.$set(that.seatList[index], 'background', that.unSelect)
                    } else {
                        this.$set(that.seatList[index], 'background', that.selected)
                    }
                } else if (that.seatList[index].background === that.unSelect) {
                    this.$set(that.seatList[index], 'background', that.selecting)
                } else if (that.seatList[index].background === that.selected) {
                    this.$set(that.seatList[index], 'background', that.selecting)
                }
            },

            // 标记座位
            markSeats(e) {
                let that = this;
                let seatList = that.seatList;
                if (e === 'normal') {
                    for (const index in seatList) {
                        if (that.seatList[index].background === that.selecting) {
                            if (that.seatList[index].backimg != that.disableImg) {
                                this.$set(that.seatList[index], 'background', that.selected);
                                this.$set(that.seatList[index], 'backimg', that.normalImg);
                            } else {
                                Message.warning("请选择未选座位！");
                            }
                        }
                    }
                } else if (e === 'preserve') {
                    for (const index in seatList) {
                        if (that.seatList[index].background === that.selecting) {
                            this.$set(that.seatList[index], 'background', that.selected);
                            this.$set(that.seatList[index], 'backimg', that.preserveImg);
                        }
                    }
                } else if (e === 'clear') {
                    for (const index in seatList) {
                        if (that.seatList[index].background === that.selecting) {
                            if (that.seatList[index].backimg !== null) {
                                this.$set(that.seatList[index], 'background', that.selected)
                            } else {
                                this.$set(that.seatList[index], 'background', that.unSelect)
                            }
                        }
                    }
                } else if (e === 'road') {
                    for (const index in seatList) {
                        if (that.seatList[index].background === that.selecting) {
                            this.$set(that.seatList[index], 'background', that.unSelect);
                            this.$set(that.seatList[index], 'backimg', null);
                        }
                    }
                }
            },

            // 清空座位
            clearSeat() {
                let that = this
                for (const index in that.seatList) {
                    if (!(that.seatList[index].backimg == this.disableImg)) {
                        this.$set(that.seatList[index], 'background', that.unSelect);
                        this.$set(that.seatList[index], 'backimg', null);
                    } else {
                        this.$set(that.seatList[index], 'background', that.selected);
                    }
                }
            },

            // 预选，不可选座位
            async preSelect() {
                let json = await getLectureClassroomIsSelected(this.theLectureId);
                if (json.success_code === 200) {
                    this.seatIsSelected = json.data;
                } else {
                    Message.error(json.message);
                }
                let that = this;
                let seatList = that.seatList;
                let seatIsSelected = that.seatIsSelected;
                for (const index in seatList) {
                    for (const choose in seatIsSelected) {
                        if (that.seatList[index].x == that.seatIsSelected[choose].seat_x
                            && that.seatList[index].y == that.seatIsSelected[choose].seat_y) {
                            this.$set(that.seatList[index], 'background', that.selected);
                            this.$set(that.seatList[index], 'backimg', that.disableImg);
                        }
                    }
                }
            },

            // 预约
            async orderSeat(seats, lecture_id) {

                // let json_1 = await selectSeatUpdateSeat(lecture_id,seat_x,seat_y);
                // let json_2 = await selectSeatUpdateLecture(lecture_id);
                // let json_3 = await selectSeatUpdateOperation(student_id,lecture_id,seat_id,ticket_code);
                // let json_4 = await selectSeatUpdateRecord(student_id,lecture_id);

                // 1、lecture_id:lecture_id
                // 3、student_id:friendsAndSelf（一定有）
                // 4、seat_x,seat_y:seats_ok[i].x,y
                // 33、seat_id:在selectSeatUpdateSeat中得到seat_id（lecture_seat_id）

                /*------------------------------------------------------------------------*/

                let the_lecture_id = lecture_id;
                // console.log("1、lecture_id----", the_lecture_id);

                let friendsAndSelf = JSON.parse(this.$cookies.get("friendsAndSelf"));
                // console.log("3、friendsAndSelf----", friendsAndSelf);
                // console.log("3、friendsAndSelf----", friendsAndSelf[0].id);

                let seats_ok = [];
                for (const seat in seats) {
                    if (seats[seat].seat_type != null) {
                        seats_ok.push(seats[seat]);
                    }
                }
                // 不一定选了座位
                // console.log("4、seats_ok----", seats_ok);
                // console.log("4、seats_ok----", seats_ok[0].x, +" " + seats_ok[0].y);

                // 先声明座位id
                let seat_id;

                /*------------------------------------------------------------------------*/

                // 选了座位
                if (seats_ok.length > 0) {
                    // 座位数、听众数相同
                    if (seats_ok.length == friendsAndSelf.length) {
                        // 一个听众、自己
                        if (friendsAndSelf.length == 1 && friendsAndSelf[0].id == this.theStudentId) {
                            let json = await findLectureByStudentId(friendsAndSelf[0].id, this.theLectureId);
                            // console.log("status_code----", json.status_code);
                            if (json.status_code === 1) {
                                Message.error("您已预约该讲座！");
                                this.changeConfirmButtonLoading(false);
                            }
                            else{
                                Message("预约中，请稍等！");
                                let json_1, json_2, json_3, json_4, json_3_3;
                                for (let i = 0; i < friendsAndSelf.length; i++) {
                                    json_1 = await selectSeatUpdateSeat(the_lecture_id, seats_ok[i].x, seats_ok[i].y);
                                    json_2 = await selectSeatUpdateLecture(the_lecture_id);
                                    json_3_3 = await findSeatId(the_lecture_id, seats_ok[i].x, seats_ok[i].y);
                                    seat_id = json_3_3.data[0].lecture_seat_id;
                                    json_3 = await selectSeatUpdateOperation(friendsAndSelf[i].id, the_lecture_id, seat_id);
                                    json_4 = await selectSeatUpdateRecord(friendsAndSelf[i].id, the_lecture_id);
                                }
                                if (json_1.success_code === 200
                                    && json_2.success_code === 200
                                    && json_3.success_code === 200
                                    && json_4.success_code === 200) {
                                    this.$notify.success({
                                        title: '成功',
                                        message: '添加成功，3秒后跳转已预约页可查看',
                                        duration: 2000
                                    });
                                    this.changeConfirmButtonLoading(false);
                                    this.timer = setTimeout(() => {
                                        this.$router.push({path: "/home/lecture_order"});
                                    }, 3000)
                                } else {
                                    this.$notify.error({
                                        title: '警告',
                                        message: json_3.message,
                                        duration: 2000
                                    });
                                    this.changeConfirmButtonLoading(false)
                                    this.timer = setTimeout(() => {
                                        this.$cookies.set("isSelect", "/lecture_list");
                                        this.$router.push({path: "/home/lecture_list"});
                                    }, 3000)
                                }
                            }
                        }
                        // n个听众，n>1
                        else {
                            Message("预约中，请稍等！");
                            let json_1, json_2, json_3, json_4, json_3_3;
                            for (let i = 0; i < friendsAndSelf.length; i++) {
                                json_1 = await selectSeatUpdateSeat(the_lecture_id, seats_ok[i].x, seats_ok[i].y);
                                json_2 = await selectSeatUpdateLecture(the_lecture_id);
                                json_3_3 = await findSeatId(the_lecture_id, seats_ok[i].x, seats_ok[i].y);
                                seat_id = json_3_3.data[0].lecture_seat_id;
                                // console.log("json_3_3--", json_3_3.data);
                                // console.log("json_3_3--", json_3_3.data[0].lecture_seat_id);
                                json_3 = await selectSeatUpdateOperation(friendsAndSelf[i].id, the_lecture_id, seat_id);
                                json_4 = await selectSeatUpdateRecord(friendsAndSelf[i].id, the_lecture_id);
                            }
                            // 这个成功状态码是最后一个人的状态码
                            // 要解决的方法，要收集每个人的状态码、错误信息、在哪个方法出错
                            if (json_1.success_code === 200
                                && json_2.success_code === 200
                                && json_3.success_code === 200
                                && json_4.success_code === 200) {
                                this.$notify.success({
                                    title: '成功',
                                    message: '添加成功，3秒后跳转已预约页可查看',
                                    duration: 2000
                                });
                                this.changeConfirmButtonLoading(false);
                                this.timer = setTimeout(() => {
                                    this.$router.push({path: "/home/lecture_order"});
                                }, 3000)
                            } else {
                                this.$notify.error({
                                    title: '警告',
                                    message: json_3.message,
                                    duration: 2000
                                });
                                this.changeConfirmButtonLoading(false)
                                this.timer = setTimeout(() => {
                                    this.$router.push({path: "/home/lecture_list"});
                                }, 3000)
                            }
                        }
                    } else {
                        Message.error("听众数、座位数需相等！");
                        this.changeConfirmButtonLoading(false);
                    }
                } else {
                    Message.error("请选择座位！");
                    this.changeConfirmButtonLoading(false);
                }
            },

            // 确定
            confirm() {
                let that = this;
                let confirmSeatList = [];
                for (const index in this.seatList) {
                    if (this.seatList[index].background === this.selected) {
                        var temp = {};
                        temp.x = this.seatList[index].x;
                        temp.y = this.seatList[index].y;
                        if (this.seatList[index].backimg === this.normalImg) {
                            temp.seat_type = 1
                        }
                        if (this.seatList[index].backimg === this.preserveImg) {
                            temp.seat_type = 2
                        }
                        confirmSeatList.push(temp)
                    }
                }
                if (confirmSeatList.length <= 0) {
                    this.$notify({
                        title: '警告',
                        message: '请至少编辑一个座位~',
                        type: 'warning',
                        duration: 2000
                    });
                    this.changeConfirmButtonLoading(false);
                    return
                }

                // 执行预约
                this.orderSeat(confirmSeatList, this.lecture_id);
            }
        },

    }
</script>


<style lang="stylus" scoped>
  .pages
    width 100%
    height 100vh;
    padding 100px 50px;
    box-sizing border-box;

    .seatSelectArea
      width 100%
      height 100%;
      position relative;

    .seatArea
      display flex
      flex-wrap: wrap;
      margin 0 auto;
      padding 5px
      border 2px dashed rgba(0, 0, 0, 0.2)
      border-radius 5px;

      .seatItem
        position absolute;
        color white;
        line-height 40px;
        border-radius: 5px;
        user-select: none;
        display flex;

        img
          width 100%
          height 100%
          border none
          object-fit cover
</style>
