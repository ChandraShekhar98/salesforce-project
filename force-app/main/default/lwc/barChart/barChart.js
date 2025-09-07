import { LightningElement, api } from 'lwc';
import chartjs from '@salesforce/resourceUrl/ChartJS';
import { loadScript } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class BarChart extends LightningElement {
    
    isChartJsInitialized = false;

    chartData = {
        type: 'horizontalBar',
        data: {
            labels: ['Sent', 'Clicked', 'Opened', 'Unsubscribed'],
            datasets: [{
                label:'Campaign email send stats',
                data: [105, 98, 89, 82],
                backgroundColor: ['#fcc603','#03adfc','#031cfc','#fc0303']
            }]
        },
        options:{
            maintainAspectRatio: false,
            legend:{
                display:false,
            },
            scales: {
                yAxes: [{
                    ticks: {
                        display: false
                    }
                }]
            },
            tooltips: {
                displayColors: false,
                callbacks: {
                    label: function(tooltipItem, data) {
                        //var label = data.datasets[tooltipItem.datasetIndex].label || '';
                        console.log('label ', label);
                        console.log('data here from chart ', data);
                        console.log('tooltip data ', tooltipItem);
                        // if (label) {
                        //     label += ': ';
                        // }
                        return label;
                    }
                }
            }
        }
    };

    connectedCallback(){
        console.log('inside bar chart component');
    }

    renderedCallback() {
        if (this.isChartJsInitialized) {
            return;
        }
        // load chartjs from the static resource
        Promise.all([loadScript(this, chartjs)])
            .then(() => {
                console.log('inside promise');
                this.isChartJsInitialized = true;
                const ctx = this.template.querySelector('canvas.barChart').getContext('2d');
                this.chart = new window.Chart(ctx, JSON.parse(JSON.stringify(this.chartData)));
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error loading Chart',
                        message: error.message,
                        variant: 'error',
                    })
                );
            });
    }
}