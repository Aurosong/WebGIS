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
    <link rel="stylesheet" href="css/openlayerLogged" type="text/css">
<%--    <link rel="stylesheet" type="text/css" href="css/openlayerLogged.css" charset="UTF-8">--%>
    <script src="js/jquery-3.6.0.js" type="text/javascript"></script>
    <script src="js/ol.js"></script>
    <title>OpenLayers example</title>
</head>

<body>
<h2 id="headTitle">My Map</h2>
<a href=""><p id="LoginMessage">Logged yet</p></a>

<%--    select tools--%>
<div id="select">
    <input type="text" name="select" class="select" placeholder="select by name">
    <button type="button" id="selectMsg" onclick="excuteSelect()">select</button>
    <div id="resultMsg">
        <em id="resultMsgPassage"></em>
    </div>
</div>

<%--    insert tools--%>
<div id="rgtName">
    <input type="text" style="width: 70%" name="registerName" placeholder="input your name">
</div><div id="rgtCode">
    <input type="text" style="width: 70%" name="registerCode" placeholder="input your password">
</div><div id="smtBtn">
    <button type="button" id="registerBtn" onclick="excuteRegister()">register</button>
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

<%--Ajax for Register--%>
<script type="text/javascript">
    function excuteRegister(){
        $.ajax({
            type:"get",
            url:"/MyWeb/Register",
            data:{
                username:$("input[name='registerName']").val(),
                password:$("input[name='registerCode']").val(),
            },
            success:function (data){
                if(data=="0"){
                    alert("format error!");
                }
                else{
                    alert("register successfully!")
                }
            }
        })
    }
</script>

<%--Ajax for Select--%>
<script type="text/javascript">
    function excuteSelect(){
        $('#resultMsgPassage').empty();
        $.ajax({
            type:"get",
            url:"/MyWeb/Ajax",
            data:{
                username:$("input[name='select']").val()
            },
            dataType:"text",
            success:function (userMsg){
                // var jsonobj = JSON.parse(userMsg);
                // console.log(jsonobj);
                $("#resultMsgPassage").append(function (index,currentHTML){
                    return "<em>"+" "+userMsg+"</em>"
                });
            }
        })
    }
</script>

<%--script for map--%>
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
        name:"OpenLayers Map",
        source: new ol.source.OSM({
            wrapX: false
        }),
    });

    var footprintMap = new ol.layer.Tile({
        visible: false,
        name:"footprintMap",
        source: new ol.source.TileWMS({
                url: 'http://localhost:8080/geoserver/Aurosong/wms',
                params: {
                    'FORMAT': 'image/png',
                    'VERSION': '1.1.1',
                    tiled: true,
                    "STYLES": '',
                    "LAYERS": 'Aurosong:citypoint',
                    "exceptions": 'application/vnd.ogc.se_inimage',
                    tilesOrigin: -180 + "," + -90
                }
        })
    });

    var projection = new ol.proj.Projection({
        code: 'EPSG:4326',
        units: 'm',
        global: true
    });

    var map = new ol.Map({
        target: 'map',
        layers:[TiandiMap_img, TiandiMap_cia, openlayersMap, footprintMap],
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