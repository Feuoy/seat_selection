export const dateFormat = function(fmt, date) {
  let ret;
  let a = new Date(date);
  let opt = {
    "Y+": a.getFullYear().toString(),        // 年
    "m+": (a.getMonth() + 1).toString(),     // 月
    "d+": a.getDate().toString(),            // 日
    "H+": a.getHours().toString(),           // 时
    "M+": a.getMinutes().toString(),         // 分
  };
  for (let k in opt) {
    ret = new RegExp("(" + k + ")").exec(fmt);
    if (ret) {
      fmt = fmt.replace(ret[1], (ret[1].length == 1) ? (opt[k]) : (opt[k].padStart(ret[1].length, "0")))
    }
  }
  return fmt;
};


export const formatTheLastHour = function(time){
  // 2019-12-02T01:55:00.000Z
  let date = new Date(time);
  return date.getHours() + ":"
    + (date.getMinutes() < 10 ? ('0' + date.getMinutes()) : date.getMinutes());
};
