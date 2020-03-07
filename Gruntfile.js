'use strict';

module.exports = function(grunt) {

  function slugify(text, useHyphens) {

    if ( typeof useHyphens === 'undefined' ) {
      useHyphens = true;
    }

    var replacement = '-';

    if ( ! useHyphens ) {
      replacement = '_';
    }

    text = text.toString().toLowerCase().trim()
      .replace(/\s+/g, replacement)                      // Replace spaces with -
      .replace(/&/g, replacement + 'and' + replacement)  // Replace & with 'and'
      .replace(/[^\w\-]+/g, '')                          // Remove all non-word chars
      .replace(/\-\-+/g, replacement);                   // Replace multiple - with single -

    if ( useHyphens ) {
      text = text.replace(/\_/g, '-');                          // Replace _ with -
    }

    return text;
  }
  function insertBeforeLastOccurrence(strToSearch, strToFind, strToInsert) {
    var n = strToSearch.lastIndexOf(strToFind);
    if ( strToFind !== 'eof' ) {
      if (n < 0) {
        return strToSearch;
      }
    }
    else {
      var matches = strToSearch.match(/\r?\n$/);

      if ( matches ) {
        n = matches.index;
      }
      else {
        return strToSearch;
      }
    }

    return strToSearch.substring(0,n) + strToInsert + strToSearch.substring(n);
  }

  // Load all tasks
  require('load-grunt-tasks')(grunt);

  // Show elapsed time
  require('time-grunt')(grunt);

  // Config
  var config = require('./config.json');

  // JS file list
  // Comment out unused JS files
  var jsFileList = [
      'assets/js/*.js'
  ];

  grunt.initConfig({

    /**
     * jshint
     * https://github.com/gruntjs/grunt-contrib-jshint
     */
    jshint: {
      options: {
        jshintrc: '.jshintrc'
      },
      all: [
        'Gruntfile.js',
        'assets/js/*.js'
      ]
    },

    /**
     * uglify
     * https://github.com/gruntjs/grunt-contrib-uglify
     */
    uglify: {
      options : {
        beautify: false,
        mangle: true,
        compress: true,
      },
      dist: {
        files: {
	        'assets/js/scripts.min.js': [jsFileList]
        }
      }
    },

    /**
     * modernizr
     * https://github.com/Modernizr/grunt-modernizr
     */
    modernizr: {
      build: {
        dest: 'assets/js/vendor/modernizr-custom.min.js',
        files: {
          'src': [
            ['assets/js/scripts.min.js'],
            ['assets/css/style.min.css']
          ]
        },
        uglify: true,
        parseFiles: true
      }
    },

    /**
     * sass import
     * https://github.com/eduardoboucas/grunt-sass-import
     */
    sass_import: {
      option: {},
      dist: {
        files: {
          'assets/sass/app.scss': [
            'assets/sass/rcc/rcc.scss', 
            'assets/sass/bootstrap/4.1.0/scss/bootstrap.scss'
          ]
        }
      }
    },
    /**
     * sass
     * https://github.com/sindresorhus/grunt-sass
     */
    sass: {
      options: {
        sourceMap: true,
        outputStyle: 'compressed'
      },
      dist: {
        files: {
          'assets/css/main.min.css': ['assets/sass/rcc/rcc.scss'],
          'assets/css/vendor/bootstrap.min.css': ['assets/sass/bootstrap/4.1.0/scss/bootstrap.scss']
        }
      }
    },

    /**
     * postcss
     * https://github.com/nDmitry/grunt-postcss
     * https://github.com/postcss/autoprefixer
     * https://github.com/ai/browserslist
     */
    postcss: {
      options: {
        map: true,
        processors: [
          require('autoprefixer')({
            browsers: ['last 3 versions', 'Safari >= 8', 'iOS >= 7', 'Android >= 4']
          })
        ]
      },
      dist: {
        src: ['assets/css/main.min.css', 
        			'assets/css/vendor/bootstrap.min.css']
      }
    },

    /**
     * browserSync
     * https://github.com/BrowserSync/grunt-browser-sync
     * http://www.browsersync.io/docs/grunt/
     */
    browserSync: {
      dev: {
        bsFiles: {
          src : [
            'assets/css/main.min.css',
            'assets/css/vendor/bootstrap.min.css',
            'assets/js/global.min.js'
          ]
        },
        options: {
          proxy: config.devUrl,
          watchTask: true
        }
      }
    },

    /**
     * watch
     * https://github.com/gruntjs/grunt-contrib-watch
     */
    watch: {
      sass: {
        files: [
          'assets/sass/rcc/**/*.scss',
          'assets/sass/bootstrap/4.1.0/scss/**/*.scss'
        ],
        tasks: ['sass_import', 'sass', 'postcss']
      },
      js: {
        files: [
          jsFileList,
          '<%= jshint.all %>'
        ],
        tasks: ['jshint', 'uglify']
      }
    }
  });

  // Register tasks
  grunt.registerTask('default', [
    'dev'
  ]);

  grunt.loadNpmTasks('grunt-contrib-copy');

  grunt.registerTask('dev', [
    'browserSync',
    'watch'
  ]);

  grunt.registerTask('build', [
    'jshint',
    'uglify',
    'sass_import',
    'modernizr',
    'sass',
    'postcss',
    'version'
  ]);

};
