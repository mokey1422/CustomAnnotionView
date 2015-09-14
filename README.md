# CustomAnnotionView
#自定义大头针视图<br>
#教程篇
## 自定义大头针
   *  一般来说系统的大头针和大头针视图就可以满足我们的基本需求在自定义之前我们先来分析了解一下系统的大头针和大头针视图<br>
   *  先明确大头针和大头针视图的分工，大头针负责存储展示内容，大头针视图负责内容展示的形式，这两者都可以自定义<br>
     *   MKPinAnnotationView 原生的，不可以设置image，就算设置也无效
     
     *   MKAnnotationView 自定义大头针的图片 但是无法设置动画，动画需要自己来实现
     *  如果使用系统原生的那种形式的话用MKPinAnnotationView
     *  如果要简单自定义的使用直接可以用MKAnnotationView的leftCalloutAccessoryView和rightCalloutAccessoryView来实现简单的定制弹出视图的样式
         MKAnnotationView.image 来控制大头针的样式
     *  要是还是不能够满足我们的需求那就要完全自定义了，下面就简单的介绍一下自定义的过程
     *  注意事项在创建大头针的时候一定要包含三个必要信息title、subtitle、coordinate即使你不需要这些属性的话也要添加上否则会你打开大头针视图的canShowCallout属性的时候会崩掉,最少要确保coordinate属性存在我习惯都带上鬼知道会不会出问题<br>
     *  存在几种不同的大头针就自定义几种不同的MKAnnotation<br>
     *  每个大头针对应一个大头针视图定义几个大头针就自定义几个大头针视图，我刚试过用系统的MKAnnotationView通过MKAnnotation的自定义类型来区分设置MKAnnotationView.image只能设置一个样式，没办法保险起见还是几个MKAnnotation对应几个MKAnnotationView；<br>
     *  总结来说其实自定义大头针视图的用法和我们的tableview的用法极其相似<br>
         * annotation就相当于我们的model
         * annotationView就相当于我们的cell，里面可以完成自定义视图
         * mapview就相当于我们的tableView

#效果图：
![](https://github.com/mokey1422/gifResourceOther/blob/master/CustomAnnotation.png)
