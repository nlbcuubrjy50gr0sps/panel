/*=========================================================================================
    File Name: chart-apex.js
    Description: Apexchart Examples
    ----------------------------------------------------------------------------------------
    Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/

$(function() {
    'use strict';

    var flatPicker = $('.flat-picker'),
        isRtl = $('html').attr('data-textdirection') === 'rtl',
        chartColors = {
            column: {
                series1: '#826af9',
                series2: '#d2b0ff',
                bg: '#f8d3ff'
            },
            success: {
                shade_100: '#7eefc7',
                shade_200: '#06774f'
            },
            donut: {
                series1: '#ffe700',
                series2: '#00d4bd',
                series3: '#826bf8',
                series4: '#2b9bf4',
                series5: '#FFA1A1'
            },
            area: {
                series3: '#a4f8cd',
                series2: '#60f2ca',
                series1: '#2bdac7'
            }
        };

    // Init flatpicker
    if (flatPicker.length) {
        var date = new Date();
        flatPicker.each(function() {
            $(this).flatpickr({
                mode: 'range',
                defaultDate: ['2019-05-01', '2019-05-10']
            });
        });
    }

    // Donut Chart
    // --------------------------------------------------------------------

    if (typeof donutChartEl !== undefined && donutChartEl !== null) {
        var donutChart = new ApexCharts(donutChartEl, donutChartConfig);
        donutChart.render();
    }
});