package xyl.flutter_java_jiao_hu;

import android.content.Intent;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;
import xyl.flutter_java_jiao_hu.CountActivity;
public class MainActivity extends FlutterActivity {
  private static final String javaKey = "samples.flutter.io/flutter_java_jiao_hu";
  MethodChannel methodChannel;
  MethodChannel.Result result;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(),javaKey).setMethodCallHandler(new  MethodChannel.MethodCallHandler(){
      @Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        System.out.println(">]methodCall=" + methodCall);
        System.out.println(">]MethodChannel.Result=" + result);
        //获取flutter调用的那个方法
        System.out.println(">]方法=" + methodCall.method);
        //flutter传进的参数await platform.invokeMethod("key_login",["a",1,true]); 数据类型是ArrayList<Object>
        System.out.println(">]参数=" + methodCall.arguments);
        if (methodCall.method.equals("key_login")) {
          key_login(result,methodCall.arguments);
        }else  if (methodCall.method.equals("key_decode")) {
          key_decode(result,methodCall.arguments);
        }else  if (methodCall.method.equals("key_startActivity")) {
          result.success("回调原生页面成功1");
          Intent intent = new Intent(MainActivity.this, CountActivity.class);
          startActivity(intent);
          result.success("在跳转之后给flutter传递失败");
        }
      }
    });
  }

  public  static int index=0;
  public void key_login(MethodChannel.Result result,Object arguments){
    //返回给flutter的数据
    result.success("java数据index="+index);
    index++;
  }

  /**
   * 解密
   * @param result
   * @param arguments
   */
  public void key_decode(MethodChannel.Result result,Object arguments){
    String str=CUDES.decrypt(arguments.toString());
    System.out.println(">]解密后="+str);
    //返回给flutter的数据
    result.success(str);
  }

}
