# react-native-sketch-draw

## For ReactNative v0.53

A React Native component for touch based drawing supporting iOS and Android. Inspired by the libraries [react-native-sketch](https://github.com/jgrancher/react-native-sketch), [react-native-signature-capture](https://github.com/RepairShopr/react-native-signature-capture) and [react-native-sketch-view](https://github.com/keshavkaul/react-native-sketch-view)

This component was written to fulfill the following use cases:

1. Basic Touch based drawing for both iOS and android.
2. Shouldn't include any UI Elements for interaction. The UI Elements can be created and customized in react native.
3. Support touch drawing, erasing of part of drawing, clearing drawing, saving of drawn images locally and opening of locally saved images.

You can change color with prop `toolColor={'#color-CSS-Hexa'}`.

![Imgur](https://i.imgur.com/K2tCYNR.png)
## Getting Started

1. `$ npm install react-native-sketch-draw --save` or `$ yarn add react-native-sketch-draw`
2. `$ react-native link react-native-sketch-draw`
3. For iOS, open your application in Xcode `open /ios/app-name.xcodeproj`.
    1. Go to `app-name/Libraries/RNSketchView.xcodeproj/SketchView`
    2. Drag `SketchDrawContainer.xib` into your application project.
    3. Click on Copy Bundle Resources and add `SketchDrawContainer.xib`.

![Imgur](https://i.imgur.com/g2uJ9s8.png)

## Usage

```javascript
import React, { Component } from 'react';
import {
    View,
    Text,
    TouchableHighlight
} from 'react-native';
import SketchDraw from 'react-native-sketch-draw';

const SketchDrawConstants = SketchDraw.constants;

const tools = {};

tools[SketchDrawConstants.toolType.pen.id] = {
    id: SketchDrawConstants.toolType.pen.id,
    name: SketchDrawConstants.toolType.pen.name,
    nextId: SketchDrawConstants.toolType.eraser.id
};
tools[SketchDrawConstants.toolType.eraser.id] = {
    id: SketchDrawConstants.toolType.eraser.id,
    name: SketchDrawConstants.toolType.eraser.name,
    nextId: SketchDrawConstants.toolType.pen.id
};

export default class DrawBoard extends Component {

    constructor(props) {
        super(props);
        this.state = {
            color: '#FFFFFF',
            toolSelected: SketchDrawConstants.toolType.pen.id
        };
    }

    isEraserToolSelected() {
        return this.state.toolSelected === SketchDrawConstants.toolType.eraser.id;
    }

    toolChangeClick() {
        this.setState({toolSelected: tools[this.state.toolSelected].nextId});
    }

    getToolName() {
        return tools[this.state.toolSelected].name;
    }

    onSketchSave(saveEvent) {
        this.props.onSave && this.props.onSave(saveEvent);
    }

    render() {
        return (
            <View style={{flex: 1, flexDirection: 'column'}}>
                <SketchDraw style={{flex: 1, backgroundColor: 'white'}} ref="sketchRef"
                selectedTool={this.state.toolSelected} 
                toolColor={'#FFFA38'} //Yelow Example! you can changIT!
                onSaveSketch={this.onSketchSave.bind(this)}
                localSourceImagePath={this.props.localSourceImagePath}/>

                <View style={{ flexDirection: 'row', backgroundColor: '#EEE'}}>
                    <TouchableHighlight underlayColor={"#CCC"} style={{ flex: 1, alignItems: 'center', paddingVertical:20 }} onPress={() => { this.refs.sketchRef.clearSketch() }}>
                        <Text style={{color:'#888',fontWeight:'600'}}>CLEAR</Text>
                    </TouchableHighlight>
                    <TouchableHighlight underlayColor={"#CCC"} style={{ flex: 1, alignItems: 'center', paddingVertical:20, borderLeftWidth:1, borderRightWidth:1, borderColor:'#DDD' }} onPress={() => { this.refs.sketchRef.saveSketch() }}>
                        <Text style={{color:'#888',fontWeight:'600'}}>SAVE</Text>
                    </TouchableHighlight>
                    <TouchableHighlight underlayColor={"#CCC"} style={{ flex: 1, justifyContent:'center', alignItems: 'center', backgroundColor:this.isEraserToolSelected() ? "#CCC" : "rgba(0,0,0,0)" }} onPress={this.toolChangeClick.bind(this)}>

                    <Text style={{color:'#888',fontWeight:'600'}}>ERASER</Text>
                    </TouchableHighlight>
                </View>
            </View>
        );
    }
}
```

## APIs and Props

### APIs

1. `clearSketch()` - Clears the view.
2. `saveSketch()` - Initiates saving of sketch.
3. `changeTool(toolId)` - Changes selected tool.
    * Tool Id can be found using SketchDraw tooltype constants eg. `SketchDraw.constants.toolType.pen.id`

#### Tool Types

1. Pen - `SketchDraw.constants.toolType.pen`
2. Eraser - `SketchDraw.constants.toolType.eraser`

### Props

1. `selectedTool` - Set the tool id to be selected.
2. `toolColor` - Set color for pen, using CSS colors.
3. `localSourceImagePath` - Local file path of the image.
4. `onSaveSketch(saveArgs)` - Callback when saving is complete.
    * `saveArgs` Is an object having the following properties -
        * `localFilePath` - Local file path of the saved image.
        * `imageWidth` - Width of the saved image.
        * `imageHeight` - Height of the saved image.

## License

[MIT](./LICENSE)
