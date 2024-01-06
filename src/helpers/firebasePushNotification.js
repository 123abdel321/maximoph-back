import { getMessaging } from 'firebase-admin/messaging';
import { poolAdm } from "../db.js";

const sendFBPushMessageUser = async (userId, message, poolSys) => {
  try {
    let poolAdmin = poolAdm;

    let [user] = await poolAdmin.query("SELECT * FROM usuarios WHERE id = ?", [userId]);
    
    if(user.length){
      user = user[0];
      
      if(user.firebase_token){
        const resPush = await getMessaging().send({
          webpush: {
            notification: {
              title: message.title,
              body: message.body,
              icon: 'https://app.maximoph.com/favicon.ico',
              requireInteraction: true
            },
          },
          token: user.firebase_token
        });
      }
      
      await poolSys.query(`INSERT INTO mensajes_push_historia (id_usuario_notificado, titulo, descripcion, vista, created_at) VALUES 
      (?, ?, ?, 0, NOW())`, [userId, message.title, message.body]);
    }
    
    //poolAdmin.end();

    return true;
  } catch (error) {
    console.log("DEBUG FB PUSH");
    console.log(error.message);
    return error.message;
  }
};

export {
  sendFBPushMessageUser
};
