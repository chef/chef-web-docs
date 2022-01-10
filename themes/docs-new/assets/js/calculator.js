const client = document.forms.namedItem("client");
const compliance = document.forms.namedItem("compliance");
const eventFeed = document.forms.namedItem("eventFeed");
const serviceGroups = document.forms.namedItem("serviceGroups");
const calculators = [client, compliance, eventFeed, serviceGroups]

let nodes = parseFloat(calculators[0]);
let data = parseFloat(calculators[1]);
let runs = parseFloat(calculators[2]);
let daily = parseFloat(calculators[3]);
let retention = parseFloat(calculators[4]);

const getNodes = [compliance, eventFeed, serviceGroups]

const handleUpdate = (e) => {
  getNodes.forEach(updateNodes);
  calculators.forEach(getDaily);
  calculators.forEach(storageTotal);
};

addEventListeners({
  selector : 'input',
  listeners : {
    'change' : handleUpdate,
    'keyup' : handleUpdate,
    'click' : handleUpdate
  },
  scope: document
},
{
  selector : 'select',
  listeners : {
    'change' : handleUpdate,
    'keyup' : handleUpdate
  },
  scope: document
},
{
  selector : 'output',
  listeners : {
    'change' : handleUpdate,
    'keyup' : handleUpdate
  },
  scope: document
});

// Custom functions to make life easier...
function addEventListeners(...configs) {
  configs.forEach(config => {
    let options = config.options || {};
    let els = Array.from((config.scope || document).querySelectorAll(config.selector));
    Object.keys(config.listeners || {}).forEach(eventName => {
      els.forEach(el => {
        el.addEventListener(eventName, config.listeners[eventName], options)
      });
    });
  });
}

function updateNodes(item) {
  item.nodes.value = client.nodes.value
}

function getDaily(item){
  item.daily.value = (item.data.value * (24/item.runs.value) * (item.nodes.value/(1024*1024))).toFixed(2);
  parseFloat(item.daily.value);
}

function storageTotal(item) {
  item.totalData.value = (item.daily.value * item.retention.value).toFixed(2);
}

// An elasticsearch node has 203
// Assumption based on
function elasticNodes(item) {
  item.result.value = item.result.value * 2;
}
