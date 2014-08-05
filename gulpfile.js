var gulp = require('gulp');
var coffee = require('gulp-coffee');
var gutil = require('gulp-util');
var rimraf = require('gulp-rimraf');
var aglio = require('gulp-aglio');
var connect = require('gulp-connect');
var spawn = require('child_process').spawn;
var node;

var paths = {
  cscripts: './src/coffee/**/*.coffee',
  jscripts: './src/js/**/*.js',
  app: './src/js/app.js',
  docs: './doc/src/*.md',
  gendocs: './doc/gen/*.html',
  gendocfolder: './doc/gen'
}

gulp.task('coffee', function(cb) {
  gulp.src(paths.cscripts)
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./src/js'))
    .on('end', function() {cb(null);})
});

gulp.task('watch', ['serve'], function() {
  gulp.watch(paths.cscripts, ['serve']);
});

gulp.task('doc', function() {
  gulp.src(paths.docs)
      .pipe(aglio({ template: 'default' }))
      .pipe(gulp.dest('doc/gen'))
      .pipe(connect.reload());
});

gulp.task('docwatch', ['docserve'], function() {
  gulp.watch(paths.docs, ['doc']);
});

gulp.task('docserve', ['doc'], function() {
  connect.server({
    root: paths.gendocfolder,
    livereload: true
  });
}); 

gulp.task('clean', function() {
  gulp.src([paths.jscripts, paths.gendocs], {read: false})
      .pipe(rimraf());
});

gulp.task('serve', ['coffee'], function() {
  if (node) node.kill();
  node = spawn('node', [paths.app], {stdio: 'inherit'});
  node.on('close', function(code) {
    if (code === 8) {
      gutil.log('Error detected, waiting for changes');
    }
  });
});

gulp.task('dev', ['watch', 'docwatch']);
gulp.task('default', ['clean', 'coffee', 'doc', 'serve'])