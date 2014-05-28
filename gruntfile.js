/*global module:false*/
module.exports = function (grunt) {

    // Project configuration.
    grunt.initConfig({
        pkg:'<json:package.json>',
        meta:{
            version:'0.1.0',
            banner:'/*! fracker - v<%= meta.version %> - ' +
                '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
                '* https://github.com/samdelagarza/fracker\n' +
                '* Copyright (c) <%= grunt.template.today("yyyy") %> ' +
                'TradeStation Technologies, Inc. All rights reserved; Licensed MIT */'
        },
        lint:{
            files:['grunt.js', './*.js', 'test/**/*.js']
        },
        /* not using this */
        test:{
		tasks: 'simplemocha'
        },
        concat:{
            dist:{
                src:['<banner:meta.banner>', '<file_strip_banner:./fracker.js>'],
                dest:'dist/fracker.js'
            }
        },
        min:{
            dist:{
                src:['<banner:meta.banner>', '<config:concat.dist.dest>'],
                dest:'dist/fracker.min.js'
            }
        },
        watch:{
            files:'<config:lint.files>',
            tasks:'lint simplemocha'
        },
        jshint:{
            options:{
                curly:true,
                eqeqeq:true,
                immed:true,
                latedef:true,
                newcap:true,
                noarg:true,
                sub:true,
                undef:true,
                boss:true,
                eqnull:true
            },
            globals:{
                exports:true
            }
        },
        uglify:{},
        simplemocha:{
            all:{
                src:'test/**/*.js'
            }
        }
    });

    // Default task.
    grunt.loadNpmTasks('grunt-simple-mocha');
    grunt.registerTask('default', 'lint simplemocha concat min');
};
