var express = require('express');

var cookieParser = require('cookie-parser');
var session = require('express-session');

var path = require('path');
var createError = require('http-errors');

var adminRouter = require('./routes/admin_routes');
var userRouter = require('./routes/user_routes');

var app = express();


// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

//托管静态文件
app.use(express.static('public'));

//
app.use(session({
    secret: 'keyboard cat', // 对session id 相关的cookie 进行签名
    resave: false,
    saveUninitialized: true, // 是否保存未初始化的会话
    cookie: {maxAge: 1000 * 60 * 60 * 24}, // 设置 session 的有效时间，单位毫秒},
}));

app.use(express.json());
app.use(express.urlencoded({extended: false}));

app.use(express.static(path.join(__dirname, 'public')));
app.use(cookieParser());

app.use('/admin/', adminRouter);
app.use('/user/', userRouter);

//设置跨域
app.all("*", function (req, res, next) {
    if (!req.get("Origin")) return next();
    // use "*" here to accept any origin
    res.set("Access-Control-Allow-Origin", "*");
    res.set("Access-Control-Allow-Methods", "GET");
    res.set("Access-Control-Allow-Headers", "X-Requested-With,Origin,Content-Type,Accept");
    // res.set('Access-Control-Allow-Max-Age', 3600);
    if ("OPTIONS" === req.method) return res.sendStatus(200);
    next();
});

// catch 404 and forward to error handler
app.use(function (req, res, next) {
    next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};
    // render the error page
    res.status(err.status || 500);
    res.render('error');
});


var server = app.listen(8081, function () {
    var host = server.address().address;
    var port = server.address().port;
    console.log("应用实例访问地址为http://%s:%s", host, port)
});


module.exports = app;

