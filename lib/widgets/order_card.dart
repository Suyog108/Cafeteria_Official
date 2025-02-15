import 'package:cafeteria_official/mainScreens/order_details_screen.dart';
import 'package:cafeteria_official/model/items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderId;
  final List<String>? separateQuantityList;
  
  OrderCard({
    this.itemCount,this.data,this.orderId,this.separateQuantityList,
});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //order Details
        Navigator.push(context, MaterialPageRoute(builder: (c)=>OrderDetails(orderId:orderId)));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        height: itemCount!*125,
        child: ListView.builder(
            itemCount: itemCount,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              Items model=Items.fromJson(data![index].data()! as Map<String,dynamic>) ;
              return placedOrderDesignWidget(model, context, separateQuantityList![index]);
            }
        ),
      ),
    );
  }
}

Widget placedOrderDesignWidget(Items model,BuildContext context,separateQuantityList)
{
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    color: Colors.grey,
    child: Row(
      children: [
        Image.network(model.thumbnailUrl!,width: 120,),
        SizedBox(width: 10,),
        Expanded(child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: Text(
                  model.title!
                ,style:const TextStyle(color: Colors.black12,fontSize:16,fontWeight: FontWeight.bold),),
                ),
                SizedBox(width: 10,),
                const Text("Rs "
                  ,style: TextStyle(color: Colors.blue,fontSize:16,fontWeight: FontWeight.bold),),
                Text(
                  model.price.toString()!
                  ,style:const TextStyle(color: Colors.black12,fontSize:16,fontWeight: FontWeight.bold),),
              ],
            ),
            Row(
              children: [
                const Text(
                  " x "
                  ,style:const TextStyle(color: Colors.black12,fontSize:16,fontWeight: FontWeight.bold),),
                Expanded(child: Text(
                  separateQuantityList
                  ,style:const TextStyle(color: Colors.black12,fontSize:16,fontWeight: FontWeight.bold),),)
              ],
            )
          ],
        ),
        ),
      ],
    ),
  );
}