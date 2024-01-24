import { getSysEnv } from "./sysEnviroment.js";
import { sendMail } from "./sendMail.js";
import { genBillPDF } from "./sysGenSystemPDF.js";
import { billEmailTemplate } from "./billEmailTemplate.js";

const sendEmailBillPDF = async (id, pool, req)=>{
  
  let razonSocial = await getSysEnv({
    name: 'razon_social',
    pool: pool
  });

  let [bill] = await pool.query(`SELECT 
      t1.id,
      t1.consecutivo,
      FORMAT(t1.valor_total,0) AS valortotal,
      t1.created_at,
      CONCAT(t3.nombre,' - ',t2.numero_interno_unidad) AS inmuebleText,
      t3.nombre AS zonaText,
      CONCAT(t2.area,' M2') AS areaText,
      FORMAT(t4.numero_documento,0) AS personaDocumento,
      CONCAT(
          IFNULL(t4.primer_nombre,''),' ',
          IFNULL(t4.segundo_nombre,''),' ',
          IFNULL(t4.primer_apellido,''),' ',
          IFNULL(t4.segundo_apellido,''),' '
      ) AS propietarioText,
      t4.email AS emailPropietario
    FROM facturas t1
      INNER JOIN inmuebles t2 ON t2.id = t1.id_inmueble
      INNER JOIN zonas t3 ON t3.id = t2.id_inmueble_zona 
      INNER JOIN personas t4 ON t4.id = t1.id_persona
    WHERE 
      t1.id = ?`,[id]);

  if (bill.length) {
    bill = bill[0];
  
    let periodoText = `${new Date(bill.created_at).toLocaleDateString('es-ES', { month: 'long' }).toUpperCase()} - ${new Date(bill.created_at).getFullYear()}`;
  
    let template = billEmailTemplate({ 
      nombre: bill.propietarioText, 
      copropiedad: razonSocial, 
      cuentaCobro: bill.consecutivo, 
      periodo: periodoText, 
      valor: bill.valortotal, 
      logo: 'https://previews.123rf.com/images/afriliaart/afriliaart1802/afriliaart180200078/95736802-dise%C3%B1o-de-logotipo-de-propiedad-inmobiliaria-y-construcci%C3%B3n-para-r%C3%B3tulo-corporativo-de-negocios.jpg'
    });
  
    let to = [
      {
        email: bill.emailPropietario,
        type: "to",
        name: razonSocial,
      },
    ];
  
    // let pdfBuffer = await genBillPDF(bill.id, pool, req);
    
    await sendMail(razonSocial, `Cuenta Cobro # ${bill.consecutivo} | Administración ${periodoText}`, template, to, {
      title: `cuenta_cobro_${bill.consecutivo}.pdf`
    });
  }

};

export {
  sendEmailBillPDF
};