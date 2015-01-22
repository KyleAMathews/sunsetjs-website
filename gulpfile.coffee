gulp = require 'gulp'
gutil = require 'gulp-util'
$ = require('gulp-load-plugins')()

gulp.task('css', ->
  gulp.src(['src/styles/*.sass', 'src/styles/*.scss'])
    .pipe($.compass({
      css: './'
      sass: 'src/styles'
      image: 'src/styles/images'
      style: 'nested'
      comments: false
      bundle_exec: true
      time: true
      require: [
        'susy',
        'modular-scale',
        'normalize-scss',
        'sass-css-importer',
        'sassy-buttons',
        'breakpoint']
    }))
    .on('error', (err) ->
      gutil.log err
    )
    .pipe($.size())
    .pipe(gulp.dest('./'))
    .pipe($.livereload())
)

gulp.task "server", ->
  gulp.src('./')
    .pipe($.webserver({
      livereload: true
      open: true
    }))

gulp.task "watch", ["server", "css"], ->
  gulp.watch('src/styles/**', ['css'])
