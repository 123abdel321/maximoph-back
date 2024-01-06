import mailchimp from "@mailchimp/mailchimp_transactional";

const mailchimpClient = mailchimp(process.env.API_KEY_MAIL);

const sendMail = async (fromName, subject, html, to, pdf) => {

    await mailchimpClient.users.ping();

    const message = {
        from_email: "no-reply@maximoph.com",
        from_name: fromName,
        subject: subject,
        html: html,
        to: to
    };

    if(pdf){
        message.attachments = [
            {
                type: "application/pdf",
                name: pdf.title,
                content: pdf.buffer.toString("base64")
            }
        ];
    }

    const response = await mailchimpClient.messages.send({message});

    const { _id } = response[0];
    
    return _id;
}

export {
    sendMail
};