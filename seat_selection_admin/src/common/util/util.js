// 格式化日期
export const formatDate = function(date,flag){
    if(date instanceof Date){
        let differTime = date.getTime()-new Date();
        let date_day = parseInt(differTime/24/60/60/1000);
        let date_hours = parseInt(Math.abs(differTime/60/60/1000));
        let date_minutes = parseInt(Math.abs(differTime/60/1000));
        let date_seconds = parseInt(Math.abs(differTime/1000));
        let weeks = ['周日','周一','周二','周三','周四','周五','周六'];
        if(flag&&date_day>=0){
            if(date_day==0)return '今天'+(date.getMonth()+1)+'月'+date.getDate()+'日'
            if(date_day==1)return '明天'+(date.getMonth()+1)+'月'+date.getDate()+'日'
            else if(date_day==2)return '后天'+(date.getMonth()+1)+'月'+date.getDate()+'日'
            else if(date_day>2)return weeks[date.getDay()]+(date.getMonth()+1)+'月'+date.getDate()+'日'
        }
        if(!flag&&date_day<=0){
            if(date_day==0){
                if(date_hours>0){
                    return date_hours+'小时前'
                }else{
                    if(date_minutes>0){
                        return date_minutes+'分钟前'
                    }else{
                        return '刚刚'
                    }
                }
            }else{
               return (date.getMonth()+1>9?(date.getMonth()+1):'0'+(date.getMonth()+1))+'-'+(date.getDate()>9?date.getDate():'0'+date.getDate())
            }
        }
    }else{
        return ''
    }
}

export const dateFormat = function(fmt, date) {
  let ret;
  let a = new Date(date);
  let opt = {
    "Y+": a.getFullYear().toString(),        // 年
    "m+": (a.getMonth() + 1).toString(),     // 月
    "d+": a.getDate().toString(),            // 日
    "H+": a.getHours().toString(),           // 时
    "M+": a.getMinutes().toString(),         // 分
    "S+": a.getSeconds().toString()          // 秒
    // 有其他格式化字符需求可以继续添加，必须转化成字符串
  };
  for (let k in opt) {
    ret = new RegExp("(" + k + ")").exec(fmt);
    if (ret) {
      fmt = fmt.replace(ret[1], (ret[1].length == 1) ? (opt[k]) : (opt[k].padStart(ret[1].length, "0")))
    };
  };
  return fmt;
}
