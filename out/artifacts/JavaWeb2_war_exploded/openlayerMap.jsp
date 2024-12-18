<!--
Created By Aurosong
Using Openlayers API
Updated: 2022.3.21
-->

<!doctype html>
<html style="overflow: hidden" lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/ol.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="css/openlayerMAP.css" charset="UTF-8">
    <script src="js/jquery-3.6.0.js" type="text/javascript"></script>
    <script src="js/ol.js"></script>
    <title>OpenLayers example</title>
</head>

<%--select tools--%>
<body>
<h2 id="headTitle">My Map</h2>
<a href="Login.jsp"><p id="LoginMessage">Click here to login</p></a>
<div id="select">
    <input type="text" readonly="readonly" name="select" class="select" placeholder="you need to login first">
    <div id="resultMsg">
        <em id="resultMsgPassage"></em>
    </div>
</div>

<%--map controllor--%>
<div id="mouse-position"></div>
<div id="scale"></div>
<div id="overview-map"></div>
<div id="map" class="map"></div>
<div id="layerControl" class="layerControl">
    <div class="title"><label>Layer List</label></div>
    <ul id="layerTree" class="layerTree"></ul>
</div>

<%--functions about map--%>
<script type="text/javascript">
    //map中的图层数组
    var layer = new Array();
    //图层名称数组
    var layerName = new Array();
    //图层可见属性数组
    var layerVisibility = new Array();

    function loadLayersControl(map, id) {
        //图层目录容器
        var treeContent = document.getElementById(id);
        //获取地图中所有图层
        var layers = map.getLayers();
        for (var i = 0; i < layers.getLength() ; i++) {
            //获取每个图层的名称、是否可见属性
            layer[i] = layers.item(i);
            layerName[i] = layer[i].get('name');
            layerVisibility[i] = layer[i].getVisible();
            //新增li元素，用来承载图层项
            var elementLi = document.createElement('li');
            // 添加子节点
            treeContent.appendChild(elementLi);
            //创建复选框元素
            var elementInput = document.createElement('input');
            elementInput.type = "checkbox";
            elementInput.name = "layers";
            elementLi.appendChild(elementInput);
            //创建label元素
            var elementLable = document.createElement('label');
            elementLable.className = "layer";
            //设置图层名称
            setInnerText(elementLable, layerName[i]);
            elementLi.appendChild(elementLable);
            //设置图层默认显示状态
            if (layerVisibility[i]) {
                elementInput.checked = true;
            }
            //为checkbox添加变更事件
            addChangeEvent(elementInput, layer[i]);
        }
    }

    function addChangeEvent(element, layer) {
        element.onclick = function () {
            if (element.checked) {
                //显示图层
                layer.setVisible(true);
            }
            else {
                //不显示图层
                layer.setVisible(false);
            }
        };
    }

    function setInnerText(element, text) {
        if (typeof element.textContent == "string") {
            element.textContent = text;
        } else {
            element.innerText = text;
        }
    }

    var TiandiMap_img = new ol.layer.Tile({
        name: "SkyMap Image Layer",
        source: new ol.source.XYZ({
            url: "http://t0.tianditu.com/DataServer?T=img_w&x={x}&y={y}&l={z}&tk=3bc6874f2b919aa581635abab7759a3f",
            wrapX: false
        })
    });

    var TiandiMap_cia = new ol.layer.Tile({
        name: "SkyMap Annotation Layer",
        source: new ol.source.XYZ({
            url: "http://t0.tianditu.com/DataServer?T=cia_w&x={x}&y={y}&l={z}&tk=3bc6874f2b919aa581635abab7759a3f",
            wrapX: false
        })
    });

    var openlayersMap = new ol.layer.Tile({
        name:"OpenLayers Vector Map",
        source: new ol.source.OSM({
            wrapX: false
        }),
    });

    var projection = new ol.proj.Projection({
        code: 'EPSG:3857',
        units: 'm',
        global: true
    });

    var map = new ol.Map({
        target: 'map',
        layers:[TiandiMap_img, TiandiMap_cia, openlayersMap],
        view: new ol.View({
            center: ol.proj.fromLonLat([114.360734, 30.541093]),//武汉大学坐标
            zoom: 11
        }),
        //-------------------添加控件-----------------------
        controls: ol.control.defaults().extend([
            new ol.control.FullScreen(),
            new ol.control.ScaleLine({
                target: document.getElementById('scale')
            }),
            new ol.control.MousePosition({
                target: document.getElementById('mouse-position'),
                coordinateFormat: ol.coordinate.createStringXY(4),
                projection: 'EPSG:4326',
            }),
            new ol.control.OverviewMap({
                target: document.getElementById('overview-map'),
                layers: [
                    new ol.layer.Tile({
                        source: new ol.source.OSM()
                    })
                ]
            }),
        ]),
    });
    loadLayersControl(map, "layerTree");
</script>

</body>
</html>