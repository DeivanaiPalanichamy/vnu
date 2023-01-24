import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxcommon/lib.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/constant/strings.dart';
import 'package:vnu/presentation/common/widgets/item_interest_widget.dart';
import 'package:vnu/constant/custom_text_style.dart';
import 'package:vnu/presentation/common/widgets/textfield.dart';
import 'package:get/get.dart';



class Controllerget extends GetxController {
  final giftuser =GiftshopList().obs;

  updategift(){
     giftuser.update((value) {
      value!.Giftname = 'Deivanai';
    });
  }
}

class GiftshopList extends StatefulWidget {
  String Giftname;

   GiftshopList({this.Giftname = 'Name'});
 
  @override
  State<GiftshopList> createState() => _GiftshopListState();
}

class _GiftshopListState extends State<GiftshopList> {
  final controller = Get.put(Controllerget());
 
  @override
  void initState() {
    super.initState();
    getGiftshop();
    controller.updategift();
  }

  Future<void> getGiftshop() async {
    context.read<GiftShopBloc>().add(GiftShopFetched());
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<GiftShopBloc, GiftShopState>(builder: (context, state) {
      int pos = state.posts.length;

      return Container(
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              if (state.posts.length > 0)
                Padding(
                  padding: EdgeInsets.only(left: Constant.padding15),
                  child: Row(
                    children: [
                      HomeWidgettitle(context, Strings.titlegiftshop),
                     /* SizedBox(width: 25),
                      
                      Obx(
                        () => Text('Name: ${controller.giftuser.value.Giftname}',
                            textAlign: TextAlign.left,
                            style: CustomTextStyle.getTitleStyle(Colors.white)),
                      ),*/
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(
              height: Constant.homeWidgetImage,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: pos, //state.posts.length,
                itemBuilder: (BuildContext ctx, index) {
                  return ItemInterest(
                      title: state.posts[index].title,
                      previewImagePath: state.posts[index].previewImagePath,
                      actionDescription: "",
                      itemType: "",
                      sysId: "",
                      transId: state.posts[index].transactionId,
                      extUrl: "");
                },
              )),
        ]),
      );
    });
  }
}
