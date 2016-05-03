#global module:false

"use strict"

module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-exec"

  grunt.initConfig
    sass:
      dist:
        options:
          bundleExec: true
        files: [{
          expand: true
          cwd: "_assets/css/"
          src: ["*.scss"]
          dest: "assets/css/"
          ext: ".css"
        }]

    copy:
      css:
        files: [{
          expand: true
          cwd: "_assets/css/"
          src: ["*.css"]
          dest: "assets/css/"
        }]
      'material-design-lite':
        files: [{
          expand: true
          cwd: "bower_components/material-design-lite/"
          src: "material.min.js"
          dest: "assets/js/"
        },
        {
          expand: true
          cwd: "bower_components/material-design-lite/"
          src: "material.min.js.map"
          dest: "assets/js/"
        },
        {
          expand: true
          cwd: "bower_components/material-design-lite/"
          src: "material.min.css"
          dest: "assets/css/"
        },
        {
          expand: true
          cwd: "bower_components/material-design-lite/"
          src: "material.min.css.map"
          dest: "assets/css/"
        }]
      odd:
        files: [{
          expand: true
          cwd: "bower_components/odd/dist"
          src: "odd.min.js"
          dest: "assets/js/"
        },
        {
          expand: true
          cwd: "bower_components/odd/dist/"
          src: "odd.css"
          dest: "assets/css/"
        }]

    exec:
      install:
        cmd: "bundle install"
      jekyll:
        cmd: "bundle exec jekyll build --trace"

    bower:
      install: {}

    watch:
      options:
        livereload: true
      css:
        files: [
          "_assets/css/**/*"
        ]
        tasks: [
          "sass"
          "copy"
          "exec:jekyll"
        ]
      html:
        files: [
          "_drafts/**/*"
          "_layouts/**/*"
          "_posts/**/*"
          "_config.yml"
          "*.html"
        ]
        tasks: [
          "exec:jekyll"
        ]

    connect:
      server:
        options:
          port: 4000
          base: '_site'
          livereload: true

  grunt.registerTask "build", [
    "sass"
    "copy"
    "exec:jekyll"
  ]

  grunt.registerTask "serve", [
    "build"
    "connect:server"
    "watch"
  ]

  grunt.registerTask "default", [
    "serve"
  ]