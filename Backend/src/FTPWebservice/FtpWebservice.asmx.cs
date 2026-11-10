

using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

namespace FtpWebservice
{


    public class bytestr
    {
        public bytestr() { }

        public string name;
        public byte[] bayt;
    }



    public class RemoteFileOrFolder
    {
        public string name;
        public FileOrFolder type;
    }

    

    public enum FileOrFolder
    {
        FILE,
        FOLDER
    }
    /// <summary>
    /// Perform FTP operations over HTTP
    /// </summary>

    [WebService(Namespace = "http://microsoft.com/webservices/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    //  [System.Web.Services.ScriptService]
    public class FtpWebservice : System.Web.Services.WebService
    {
        public static FtpClient ftpClient = new FtpClient();

        public static FtpClient ftpClient2 = new FtpClient();



        string cnStr = ConfigurationManager.ConnectionStrings["Db18Connection"].ConnectionString;
          
        string token = ConfigurationManager.AppSettings["mobtoken"];

        string ftpUserName = ConfigurationManager.AppSettings["ftpUserName"];
        string ftpPassword = ConfigurationManager.AppSettings["ftpPassword"];
        [WebMethod]
        public void CheckToken()
        {


            //          IncomingWebRequestContext request = WebOperationContext.Current.IncomingRequest;
            string mobtoken = HttpContext.Current.Request.Headers["mobtoken"];


            //IncomingWebRequestContext request = WebOperationContext.Current.IncomingRequest;
            //WebHeaderCollection headers = request.Headers;
            // System.ServiceModel.Web.WebOperationContext ctx = System.ServiceModel.Web.WebOperationContext.Current;
            //String request_header_value1 = ctx.IncomingRequest.Headers["Incoming_Req_Header_Key1"].ToString();
            //      string dd = WebOperationContext.Current.IncomingRequest.Headers["mobtoken"];

            //           var httpRequestProperty = new HttpRequestMessageProperty();
            //httpRequestProperty.Headers["xd"] = "xd";
            //OperationContext.Current.OutgoingMessageProperties[HttpRequestMessageProperty.Name] = httpRequestProperty; 


            if ((mobtoken != null) && (mobtoken == token))
            {
                int aa = 7;
            }
            else
            {
                throw new AccessViolationException();
                //VersionNotFoundException();// Exception("Not");
                //  throw new ArgumentNullException();
            }
        }



        [WebMethod]
        public string Connect(string server, string username, string password)
        {
            CheckToken();
            if (username.IndexOf("perrovadi") > -1) username = username.Replace("perrovadi", "usergis");

            if (password.IndexOf("304229808") > -1) password = password.Replace("304229808", "G1s_2014_ada");

            string rezs = ftpClient.connect(server, username, password) + "Ikinci:  " + ftpClient2.connect("172.16.0.59", username, password);
            return rezs;
        }


        [WebMethod(BufferResponse = false)]
        public bytestr[] DownloadMem(string remoteFolder, string remoteFile)
        {

            CheckToken();
            string[] parts = remoteFile.Split(',');
            string fileName = "";
            string remfileName = "";

            bytestr[] strbayt = new bytestr[parts.Length];


            for (int i = 0; i < parts.Length; i++)
            {

                fileName = parts[i];
                remfileName = remoteFolder + @"/" + fileName;

                bytestr strbaytitem = new bytestr();

                strbaytitem.name = fileName;
                //    strbaytitem.bayt = ftpClient.downloadbyte(remfileName);
                if (remoteFolder.IndexOf("Mufettis") > -1) strbaytitem.bayt = ftpClient2.downloadbyte(remfileName);
                else strbaytitem.bayt = ftpClient.downloadbyte(remfileName);

                strbayt[i] = strbaytitem;

            }

            return strbayt;
        }




        [WebMethod]
        public bytestr[] qdown(string remoteFolder, string remoteFile)
        {
            CheckToken();
            string[] parts = remoteFile.Split(',');
            string fileName = "";
            string remfileName = "";

            bytestr[] strbayt = new bytestr[parts.Length];

            for (int i = 0; i < parts.Length; i++)
            {

                fileName = parts[i];
                remfileName = remoteFolder + @"/" + fileName;

                bytestr strbaytitem = new bytestr();

                //   FileStream outputStream = new FileStream(FilePath + "\\" + FileName, FileMode.Create); 
                MemoryStream outputStream = new MemoryStream();
                FtpWebRequest reqFTP; //= (FtpWebRequest)FtpWebRequest.Create("ftp://172.16.0.19/" + remfileName);

                if (remoteFolder.IndexOf("Mufettis") > -1) reqFTP = (FtpWebRequest)FtpWebRequest.Create("ftp://172.16.0.59/" + remfileName);
                else reqFTP = (FtpWebRequest)FtpWebRequest.Create("ftp://172.16.0.19/" + remfileName);
                reqFTP.Method = WebRequestMethods.Ftp.DownloadFile;
                reqFTP.UsePassive = true;
                reqFTP.UseBinary = true;
                reqFTP.KeepAlive = false;
                // This example assumes the FTP site uses anonymous logon.
                reqFTP.Credentials = new NetworkCredential("usergis", "G1s_2014_ada");

                FtpWebResponse response = (FtpWebResponse)reqFTP.GetResponse();
                Stream ftpStream = response.GetResponseStream();
                long cl = response.ContentLength;
                int bufferSize = 2048;
                int readCount;
                byte[] buffer = new byte[bufferSize];
                readCount = ftpStream.Read(buffer, 0, bufferSize);
                while (readCount > 0)
                {
                    outputStream.Write(buffer, 0, readCount);
                    readCount = ftpStream.Read(buffer, 0, bufferSize);
                }
                strbaytitem.name = fileName;
                strbaytitem.bayt = outputStream.ToArray();
                ftpStream.Close();
                outputStream.Close();
                response.Close();

                strbayt[i] = strbaytitem;
            }
            return strbayt;
        }

        [WebMethod]
        public ArrayList qdownmnew(string remoteFolder, string remoteFile)
        {
           CheckToken();
            ArrayList list = new ArrayList();
            string[] parts = remoteFile.Split(',');
            string fileName = "";
            string remfileName = "";

            bytestr[] strbayt = new bytestr[parts.Length];

            for (int i = 0; i < parts.Length; i++)
            {

                fileName = parts[i];

                string ffe = fileName.Substring(3, 4);
                remfileName = remoteFolder + @"/f/" + ffe + @"/" + fileName;
                bytestr strbaytitem = new bytestr();

                //   FileStream outputStream = new FileStream(FilePath + "\\" + FileName, FileMode.Create); 
                MemoryStream outputStream = new MemoryStream();
                FtpWebRequest reqFTP; //= (FtpWebRequest)FtpWebRequest.Create("ftp://172.16.0.19/" + remfileName);

                if (remoteFolder.IndexOf("Mufettis") > -1) reqFTP = (FtpWebRequest)FtpWebRequest.Create("ftp://172.16.0.59/" + remfileName);
                else reqFTP = (FtpWebRequest)FtpWebRequest.Create("ftp://172.16.0.19/" + remfileName);
                reqFTP.Method = WebRequestMethods.Ftp.DownloadFile;
                reqFTP.UsePassive = true;
                reqFTP.UseBinary = true;
                reqFTP.KeepAlive = false;
                // This example assumes the FTP site uses anonymous logon.
                reqFTP.Credentials = new NetworkCredential("usergis", "G1s_2014_ada");

                FtpWebResponse response = (FtpWebResponse)reqFTP.GetResponse();
                Stream ftpStream = response.GetResponseStream();
                long cl = response.ContentLength;
                int bufferSize = 2048;
                int readCount;
                byte[] buffer = new byte[bufferSize];
                readCount = ftpStream.Read(buffer, 0, bufferSize);
                while (readCount > 0)
                {
                    outputStream.Write(buffer, 0, readCount);
                    readCount = ftpStream.Read(buffer, 0, bufferSize);
                }
                strbaytitem.name = fileName;
                strbaytitem.bayt = outputStream.ToArray();
                ftpStream.Close();
                outputStream.Close();
                response.Close();
                list.Add(strbaytitem);
                strbayt[i] = strbaytitem;
            }

            //if (strbayt.Length == 1) {
            //    bytestr[][] dertt= new bytestr[1][] { strbayt};
            //    return dertt[0]; } 
            //        else
            //    return strbayt;
            return list;
        }
        [WebMethod]
public bytestr[] qdownm(string remoteFolder, string remoteFile)
{
           CheckToken();

	string[] array = remoteFile.Split(',');
	string text = "";
	string text2 = "";
	bytestr[] array2 = new bytestr[array.Length];
	for (int i = 0; i < array.Length; i++)
	{
		text = array[i];
		string text3 = text.Substring(3, 4);
		text2 = remoteFolder + "/f/" + text3 + "/" + text;
		bytestr bytestr2 = new bytestr();
		MemoryStream memoryStream = new MemoryStream();
		FtpWebRequest ftpWebRequest = ((remoteFolder.IndexOf("Mufettis") <= -1) ? ((FtpWebRequest)WebRequest.Create("ftp://172.16.0.19/" + text2)) : ((FtpWebRequest)WebRequest.Create("ftp://172.16.0.59/" + text2)));
		ftpWebRequest.Method = "RETR";
		ftpWebRequest.UsePassive = true;
		ftpWebRequest.UseBinary = true;
		ftpWebRequest.KeepAlive = false;
		ftpWebRequest.Credentials = new NetworkCredential("usergis", "G1s_2014_ada");
		FtpWebResponse ftpWebResponse = (FtpWebResponse)ftpWebRequest.GetResponse();
		Stream responseStream = ftpWebResponse.GetResponseStream();
		_ = ftpWebResponse.ContentLength;
		int num = 2048;
		byte[] buffer = new byte[num];
		for (int num2 = responseStream.Read(buffer, 0, num); num2 > 0; num2 = responseStream.Read(buffer, 0, num))
		{
			memoryStream.Write(buffer, 0, num2);
		}
		bytestr2.name = text;
		bytestr2.bayt = memoryStream.ToArray();
		responseStream.Close();
		memoryStream.Close();
		ftpWebResponse.Close();
		array2[i] = bytestr2;
	}
	return array2;
}



        public class varyox
        {
            public varyox() { }

            public bool vardir;
            public DateTime vaxt;
            public string exte;

        }
        public varyox checkftp(string imageFile)
        {
            string usser = "usergis";
            string passw = "G1s_2014_ada";
            string sserv = "ftp://172.16.0.19/";


            varyox varsa = new varyox();

            varsa.vardir = false;
            varsa.vaxt = DateTime.Now;



            int index = imageFile.LastIndexOf('.');

            varsa.exte = imageFile.Substring(index + 1);

            var request = (FtpWebRequest)WebRequest.Create(sserv + imageFile);
            request.Credentials = new NetworkCredential(usser, passw);
            request.UseBinary = true;
            request.Method = WebRequestMethods.Ftp.GetDateTimestamp;

            try
            {
                FtpWebResponse response = (FtpWebResponse)request.GetResponse();

                varsa.vardir = true;
                varsa.vaxt = response.LastModified;
            }
            catch (WebException ex)
            {
                ///    FtpWebResponse response = (FtpWebResponse)ex.Response;
                ////    if (response.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailable)
                //    {


                varsa.vardir = false;


                //     }

            }




            return varsa;
        }

        [WebMethod]
        public bytestr Qdownpng(string remoteFile)
        {
            CheckToken();
            string remoteFolder = "kadrs";
            string remoteFolderik = @"kadrs/ikon";
            string usser = "usergis";
            string passw = "G1s_2014_ada";
            string sserv = "ftp://172.16.0.19/";



            bytestr strbayt = new bytestr();

            varyox esesvar;
            varyox pngvar;

            string remfileName = remoteFolderik + @"/" + remoteFile + ".png";
            string jremfileName = remoteFolder + @"/" + remoteFile + ".jpg";
            string bremfileName = remoteFolder + @"/" + remoteFile + ".bmp";
            string premfileName = remoteFolder + @"/" + remoteFile + ".png";

            esesvar = checkftp(jremfileName);

            if (!esesvar.vardir)
            {
                esesvar = checkftp(bremfileName);
                if (!esesvar.vardir)
                {
                    esesvar = checkftp(premfileName);


                    if (!esesvar.vardir)
                    {
                        esesvar = checkftp(remfileName);

                        if (!esesvar.vardir)
                        {

                            strbayt.name = "yoxdur.png";
                            strbayt.bayt = Convert.FromBase64String(@"iVBORw0KGgoAAAANSUhEUgAAAEgAAABgCAYAAAC+EjQcAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAD2EAAA9hAag/p2kAAAVHSURBVHhe7Zo9UuMwFMdf9iwJRYYTOCcINFS06Zwyaego6WiSknS0VNuQnCA+AUOBfZUd79OXLevDb7122LC834wm4Eiy9I/0l6zn0a/yVwlMlB/6k4kwKhH9NxOARxABC0TAAhGwQAQsEAELRMACEbBABCwQAQtEwAIRsEAELBABC0TAAhGwQAQDCnSA5WgEIzctD/r7fhyWor4ZbAt9IcZhKe87qzIWsJ2JsktsYXcGEajYzrABV7DT/zfYXckGD6TTp9NfoGILi3Um/0z3JYgTXDvtU/kV6vR3v2Bn5k/yvsfVWF/oR2+BitcXEPIkmxye5uqazfzJiLSDn19wFH2KSQuRxK8aElBNT8uzGv5BgKN3JstY3uR5UD96CzS+voUEP7P1pKMhK/Oc6OlpI+uabTFHC0KcyRpHbwKb/AgDzSiP/iNovILnjZAI0YZcpbZOHh5BaSM6aPvWHuSMzNYwiQqOK+YniCPBRg1EXqJOIsYWTGjgFiZvUqI4PvmmRMnx+7Q0xdDHdP59iQLGy+5TeT/0RH3B3KuuqwsDCuRQdbJOTZHaqQWx/7dSssGuBxhYoNOZNE69o542uZ6Cuwcz5SKbSitdBTdVggQSZXqwGMiI2+gpkO4oYajj1b32lXfI5ZUJTLVtdUN5zvF5g38JjRb0zronPQXSHcVf87FtASs+4E18JlMsIRjDxaX4TAGHvTZnO+WgBt0lXIQMuFoYMli33ngAsEH90HNeppDJWF5U+wJSlXO9oTZ7O7/rSXhFm7Xjbedo0ugxslGtKSCeZ7x2ckzYFwgJiXyOJj1eHa1p4aL3OYFttNxhY89dsHNQHlc4EQnwuUsV38HDiczoNO8Hie3+wxTyP+nkuSPH0cDUU+fvhvU5cRKBJNqcG8b8BRlYoHoFkqnL1vlM4XcUCU73qPGfwAIRsEAELBDB1xLInEF/YgyJRxABC0TAAhE0BKpiVLE5rmNO3vfmupW8KqoYlhthNbFzN+7uHMtG2hSN2Qf8SvVP3N+um4j3y/10hTmECj9k+mcyzqOFm5xHDXNuZD+fha7Zh2x2StJUXbfqDZ4TCUwdVl51r7RM7XOo2OG/xnsWM0/i3mOUuaFVYX1Q5jQwdopYCarzB+qs82CyGxE5uewuUCR/BP9hNdjouvL6fk5nXSL11NfxlwyVj5VDqg72FKjLCYNv0uNruMWaIXuB12puFvD6IsKgKdxUB4M5vMu3Fm7hOniwbuoxkQyNOXDPdrDD8snmuRkZzd/lyxBweeEdtpkwd18ug5GAMIFVbAyre3GOmcGLUciEidMbCLx/QPAGH44J1h1N4DaoLn4zVfGPf014mZ/fyDhWtn6UK87hp4jiJbC56y6PH7rBVWsh4uqCDNaLcEwte2+Mu39GZB80hzsxDeQ7PQdQ+rhTycTE7KloUbyCnJVVLExRbBdyNKIPqIirGyGdTNXoevvwhDPvIvlk4OoZz9sR7UU+xuR0sryuIroqWGWDy3dlwGGjNytpYxWz2xMw3oapE3lDfYnReuRaNbTl8L3OE0iNlSiy6nmiIXYHrRTaB3XJO7hA2Ht1Q6pGe4+ik1uk+qUDdRmRw3smnUQ5I4ZfeUMkWU8g74lGUGCP8Y2ImDSCz1fyFZTYPue7oIXSOMP6m48egTOCzGspinR/4vf/vgAcFyOIexAjYYEIWCACFoiABSJggQhYIAIWiIAFImCBCFggAhaIgAUiYIEIWCACFoiABSJggQhYIAIWiIAFImCBCFggAhaIgAUiYIEIWCACFoiABSJggQhYIAIWiIAFagXgN9SSWY1eXgNuAAAAAElFTkSuQmCC");
                            return strbayt;

                        }
                        else esesvar.exte = "lox";

                    }
                }

            }

            pngvar = checkftp(remfileName);

            if ((!pngvar.vardir) || (pngvar.vaxt < esesvar.vaxt))
            {

                MemoryStream outputStream = new MemoryStream();
                FtpWebRequest reqFTP = (FtpWebRequest)FtpWebRequest.Create(sserv + remoteFolder + @"/" + remoteFile + "." + esesvar.exte);
                reqFTP.Method = WebRequestMethods.Ftp.DownloadFile;
                reqFTP.UsePassive = true;
                reqFTP.UseBinary = true;
                reqFTP.KeepAlive = false;
                // This example assumes the FTP site uses anonymous logon.
                reqFTP.Credentials = new NetworkCredential(usser, passw);
                // reqFTP.Credentials = new NetworkCredential("usergis", "G1s_2014_ada");
                FtpWebResponse rresponse = (FtpWebResponse)reqFTP.GetResponse();
                Stream ftpStream = rresponse.GetResponseStream();
                long cl = rresponse.ContentLength;
                int bufferSize = 2048;
                int readCount;
                byte[] buffer = new byte[bufferSize];
                readCount = ftpStream.Read(buffer, 0, bufferSize);
                while (readCount > 0)
                {
                    outputStream.Write(buffer, 0, readCount);
                    readCount = ftpStream.Read(buffer, 0, bufferSize);
                }

                outputStream.Seek(0, SeekOrigin.Begin);

                Image image = Image.FromStream(outputStream);

                using (Bitmap newImage = new Bitmap(72, 96, PixelFormat.Format24bppRgb))
                using (Graphics graphics = Graphics.FromImage(newImage))
                {
                    graphics.CompositingQuality = CompositingQuality.HighQuality;

                    graphics.SmoothingMode = SmoothingMode.HighQuality;

                    graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    graphics.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    graphics.DrawImage(image, new Rectangle(0, 0, 72, 96));
                    //    newImage.(outputFile, ImageFormat.Png);

                    ftpStream.Close();
                    outputStream.Close();
                    rresponse.Close();

                    using (MemoryStream memoryStream = new MemoryStream())
                    {
                        newImage.Save(memoryStream, ImageFormat.Png);



                        memoryStream.Seek(0, SeekOrigin.Begin);
                        FtpWebRequest request = (FtpWebRequest)WebRequest.Create(sserv + remfileName);
                        request.Method = WebRequestMethods.Ftp.UploadFile;

                        // This example assumes the FTP site uses anonymous logon.
                        request.Credentials = new NetworkCredential(usser, passw);

                        byte[] fileContents = memoryStream.ToArray();
                        request.UseBinary = true;
                        request.ContentLength = fileContents.Length;

                        Stream requestStream = request.GetRequestStream();
                        requestStream.Write(fileContents, 0, fileContents.Length);
                        requestStream.Close();

                        FtpWebResponse responses = (FtpWebResponse)request.GetResponse();

                        Console.WriteLine("Upload File Complete, status {0}", responses.StatusDescription);
                        requestStream.Close();
                        memoryStream.Close();
                        responses.Close();



                        strbayt.name = remoteFile + ".png";
                        strbayt.bayt = memoryStream.ToArray();
                    }
                }
            }

            else
            {
                MemoryStream outputStream = new MemoryStream();
                FtpWebRequest reqFTP = (FtpWebRequest)FtpWebRequest.Create(sserv + remfileName);
                reqFTP.Method = WebRequestMethods.Ftp.DownloadFile;
                reqFTP.UsePassive = true;
                reqFTP.UseBinary = true;
                reqFTP.KeepAlive = false;
                // This example assumes the FTP site uses anonymous logon.
                reqFTP.Credentials = new NetworkCredential(usser, passw);
                // reqFTP.Credentials = new NetworkCredential("usergis", "G1s_2014_ada");
                FtpWebResponse rresponse = (FtpWebResponse)reqFTP.GetResponse();
                Stream ftpStream = rresponse.GetResponseStream();
                long cl = rresponse.ContentLength;
                int bufferSize = 2048;
                int readCount;
                byte[] buffer = new byte[bufferSize];
                readCount = ftpStream.Read(buffer, 0, bufferSize);
                while (readCount > 0)
                {
                    outputStream.Write(buffer, 0, readCount);
                    readCount = ftpStream.Read(buffer, 0, bufferSize);
                }
                strbayt.name = remoteFile + ".png";
                strbayt.bayt = outputStream.ToArray();
                ftpStream.Close();
                outputStream.Close();
                rresponse.Close();
            }



            return strbayt;
        }



        [WebMethod]
        public string qup(byte[] fileData, string filename, string remotePath)
        {
            CheckToken();
            FtpWebRequest requestc;

            if (remotePath.IndexOf("Mufettis") > -1) requestc = (System.Net.FtpWebRequest)System.Net.FtpWebRequest.Create(new Uri("ftp://172.16.0.59/" + remotePath));
            else requestc = (System.Net.FtpWebRequest)System.Net.FtpWebRequest.Create(new Uri("ftp://172.16.0.19/" + remotePath));


            //  FtpWebRequest requestc = (FtpWebRequest)WebRequest.Create("ftp://172.16.0.19/" + remotePath);
            requestc.Method = WebRequestMethods.Ftp.MakeDirectory;
            requestc.Credentials = new NetworkCredential("usergis", "G1s_2014_ada");
            //using (var resp = (FtpWebResponse)requestc.GetResponse())
            //{
            //    //Console.WriteLine(resp.StatusCode);
            //    string fileNamedd = resp.StatusCode.ToString();
            //}

            try
            {
                FtpWebResponse resp = (FtpWebResponse)requestc.GetResponse();


            }
            catch (WebException ex)
            {
            }



            if (filename.IndexOf("\\") != -1 || filename.IndexOf("/") != -1)
            {
                throw new Exception("Filename invalid");
            }
            string tempfolder= Path.GetTempPath();
            FileStream fs = new FileStream(tempfolder + filename, FileMode.CreateNew);
            fs.Write(fileData, 0, fileData.Length);
            fs.Flush();
            fs.Close();

            //      filename = "rep2.bak";

            System.IO.FileInfo _FileInfo = new System.IO.FileInfo(tempfolder + filename);

            // Create FtpWebRequest object from the Uri provided
            System.Net.FtpWebRequest _FtpWebRequest;//= (System.Net.FtpWebRequest)System.Net.FtpWebRequest.Create(new Uri("ftp://172.16.0.19/" + remotePath + @"/" + filename));

            if (remotePath.IndexOf("Mufettis") > -1) _FtpWebRequest = (System.Net.FtpWebRequest)System.Net.FtpWebRequest.Create(new Uri("ftp://172.16.0.59/" + remotePath + @"/" + filename));
            else _FtpWebRequest = (System.Net.FtpWebRequest)System.Net.FtpWebRequest.Create(new Uri("ftp://172.16.0.19/" + remotePath + @"/" + filename));
            // Provide the WebPermission Credintials
            _FtpWebRequest.Credentials = new System.Net.NetworkCredential("usergis", "G1s_2014_ada");

            // By default KeepAlive is true, where the control connection is not closed
            // after a command is executed.
            _FtpWebRequest.KeepAlive = false;

            // set timeout for 20 seconds
            _FtpWebRequest.Timeout = 20000;

            // Specify the command to be executed.
            _FtpWebRequest.Method = System.Net.WebRequestMethods.Ftp.UploadFile;

            // Specify the data transfer type.
            _FtpWebRequest.UseBinary = true;

            _FtpWebRequest.UsePassive = true;

            _FtpWebRequest.KeepAlive = false;

            // Notify the server about the size of the uploaded file
            _FtpWebRequest.ContentLength = _FileInfo.Length;

            // The buffer size is set to 2kb
            int buffLength = 1024;
            byte[] buff = new byte[buffLength];

            // Opens a file stream (System.IO.FileStream) to read the file to be uploaded
            System.IO.FileStream _FileStream = _FileInfo.OpenRead();

            // Stream to which the file to be upload is written
            System.IO.Stream _Stream = _FtpWebRequest.GetRequestStream();

            // Read from the file stream 2kb at a time
            int contentLen = _FileStream.Read(buff, 0, buffLength);

            // Till Stream content ends
            while (contentLen != 0)
            {
                // Write Content from the file stream to the FTP Upload Stream
                _Stream.Write(buff, 0, contentLen);
                contentLen = _FileStream.Read(buff, 0, buffLength);
            }

            // Close the file stream and the Request Stream
            _Stream.Close();
            _Stream.Dispose();
            _FileStream.Close();
            _FileStream.Dispose();



            File.Delete(tempfolder + filename);
            return "Upload," + filename;
        }


        [WebMethod]
        public string qdownf(string remoteFolder, string remoteFile)
        {
            CheckToken();
            string[] parts = remoteFile.Split(',');
            string fileName = "";
            string remfileName = "";

            bytestr[] strbayt = new bytestr[parts.Length];


            //   FtpWebRequest reqFTP; 




            for (int i = 0; i < parts.Length; i++)
            {

                fileName = parts[i];
                remfileName = remoteFolder + @"/" + fileName;

                bytestr strbaytitem = new bytestr();

                strbaytitem.name = fileName;



                //use Switch statement to identify the ftpServerIP 

                FileStream outputStream = new FileStream("c:\\temp\\" + fileName, FileMode.Create);
                //    MemoryStream outputStream = new MemoryStream();
                FtpWebRequest reqFTP;// = (FtpWebRequest)FtpWebRequest.Create("ftp://172.16.0.19/" + remfileName);
                if (remoteFolder.IndexOf("Mufettis") > -1) reqFTP = (FtpWebRequest)FtpWebRequest.Create("ftp://172.16.0.59/" + remfileName);
                else reqFTP = (FtpWebRequest)FtpWebRequest.Create("ftp://172.16.0.19/" + remfileName);

                reqFTP.Method = WebRequestMethods.Ftp.DownloadFile;
                reqFTP.UsePassive = true;
                reqFTP.UseBinary = true;
                reqFTP.KeepAlive = false;
                // This example assumes the FTP site uses anonymous logon.
                reqFTP.Credentials = new NetworkCredential("usergis", "G1s_2014_ada");

                FtpWebResponse response = (FtpWebResponse)reqFTP.GetResponse();
                Stream ftpStream = response.GetResponseStream();
                long cl = response.ContentLength;
                int bufferSize = 2048;
                int readCount;
                byte[] buffer = new byte[bufferSize];
                readCount = ftpStream.Read(buffer, 0, bufferSize);
                while (readCount > 0)
                {
                    outputStream.Write(buffer, 0, readCount);
                    readCount = ftpStream.Read(buffer, 0, bufferSize);
                }

                ftpStream.Close();
                outputStream.Close();
                response.Close();


            }

            return "OKEY";
        }





         


        [WebMethod]
        public string Disconnect()
        {
            CheckToken();
            string seeee = ftpClient.disconnect() + ftpClient2.disconnect();
            return seeee;
        }

        [WebMethod]
        public List<RemoteFileOrFolder> getRemoteFolder(string path)
        {
            CheckToken();
            List<RemoteFileOrFolder> lTree = new List<RemoteFileOrFolder>();
            ArrayList alItems = ftpClient.getRemoteFolder(path);
            foreach (RemoteFileOrFolder ftpItem in alItems)
            {
                lTree.Add(ftpItem);
            }
            return lTree;
        }

        [WebMethod]
        public string Upload(byte[] fileData, string filename, string remotePath)
        {
            CheckToken();
            if (filename.IndexOf("\\") != -1 || filename.IndexOf("/") != -1)
            {
                throw new Exception("Filename invalid");
            }

              string tempfolder= Path.GetTempPath();

            FileStream fs = new FileStream(tempfolder + filename, FileMode.CreateNew);
            fs.Write(fileData, 0, fileData.Length);
            fs.Flush();
            fs.Close();

            if (remotePath.IndexOf("Mufettis") > -1)
                ftpClient2.upload(tempfolder + filename, remotePath);
            else ftpClient.upload(tempfolder + filename, remotePath);

            File.Delete(tempfolder + filename);
            return "Upload";
        }


        [WebMethod]
        public string Rename(string remoteFile, string newName)
        {
            CheckToken();
            return ftpClient.rename(remoteFile, newName);
        }

        [WebMethod]
        public string Delete(string remoteFile)
        {
            CheckToken();
            return ftpClient.delete(remoteFile);
        }

        [WebMethod]
        public string CreateFolder(string parentFolder, string folderName)
        {
            CheckToken();
            return ftpClient.createFolder(parentFolder, folderName);
        }

    }


    public class FtpClient
    {


        private NetworkStream NetStrm;
        private string server = "";

        public event FTPMessageDelegate FTPMessageEvent;

        string cnStr = ConfigurationManager.ConnectionStrings["Db18Connection"].ConnectionString;
    
        string token = ConfigurationManager.AppSettings["mobtoken"];

        string ftpUserName = ConfigurationManager.AppSettings["ftpUserName"];
        string ftpPassword = ConfigurationManager.AppSettings["ftpPassword"];
        [WebMethod, SoapHeader("spAuthenticationHeader")]
        public void CheckToken()
        {


            //          IncomingWebRequestContext request = WebOperationContext.Current.IncomingRequest;
            string mobtoken = HttpContext.Current.Request.Headers["mobtoken"];


            //IncomingWebRequestContext request = WebOperationContext.Current.IncomingRequest;
            //WebHeaderCollection headers = request.Headers;
            // System.ServiceModel.Web.WebOperationContext ctx = System.ServiceModel.Web.WebOperationContext.Current;
            //String request_header_value1 = ctx.IncomingRequest.Headers["Incoming_Req_Header_Key1"].ToString();
            //      string dd = WebOperationContext.Current.IncomingRequest.Headers["mobtoken"];

            //           var httpRequestProperty = new HttpRequestMessageProperty();
            //httpRequestProperty.Headers["xd"] = "xd";
            //OperationContext.Current.OutgoingMessageProperties[HttpRequestMessageProperty.Name] = httpRequestProperty; 


            if ((mobtoken != null) && (mobtoken == token))
            {
                int aa = 7;
            }
            else
            {
                throw new AccessViolationException();
                //VersionNotFoundException();// Exception("Not");
                //  throw new ArgumentNullException();
            }
        }



        public string connect(string host, string username, string password)
        {
            CheckToken();
            this.server = host;

            try
            {
                this.NetStrm = new TcpClient(host, 0x15).GetStream();
                StreamReader reader = new StreamReader(this.NetStrm);
                string message = reader.ReadLine();
                while (message.StartsWith("220-"))
                {
                    message = reader.ReadLine();
                    this.OnFTPMessageEvent(message);
                }
                this.OnFTPMessageEvent(message);
                message = this.sendFTPcmd("USER " + username + "\r\n");
                this.OnFTPMessageEvent(message);
                message = this.sendFTPcmd("PASS " + password + "\r\n");
                this.OnFTPMessageEvent(message);
                this.server = host;


                return message;


            }

            catch (Exception)
            {

                return "Server yoxdur";

            }




        }

        public string createFolder(string parentFolder, string folderName)
        {
            string message = "";
            folderName = folderName.Replace(@"\", "/");
            parentFolder = parentFolder.Replace(@"\", "/");
            this.OnFTPMessageEvent("CWD " + parentFolder + "\r\n");
            this.sendFTPcmd("CWD " + parentFolder + "\r\n");
            this.OnFTPMessageEvent("MKD " + folderName + "\r\n");
            message = this.sendFTPcmd("MKD " + folderName + "\r\n");
            this.OnFTPMessageEvent(message);

            return "createFolder";
        }

        private NetworkStream createPassiveConnection()
        {
            int num = 0;
            int port = 0;
            string message = "";
            message = this.sendFTPcmd("PASV\r\n");
            this.OnFTPMessageEvent(message);
            while (!message.StartsWith("227"))
            {
                message = new StreamReader(this.NetStrm).ReadLine();
                this.OnFTPMessageEvent(message);
            }
            string[] strArray = message.Split(",".ToCharArray());
            num = Convert.ToInt16(strArray[4]) * 0x100;
            strArray[5] = strArray[5].Substring(0, strArray[5].IndexOf(")"));
            port = Convert.ToInt16(strArray[5]) + num;
            TcpClient client = new TcpClient(this.server, port);
            return client.GetStream();
        }

        private byte[] cropByteArray(byte[] inputArray, int crop)
        {
            byte[] buffer = new byte[crop];
            for (int i = 0; i < crop; i++)
            {
                buffer[i] = inputArray[i];
            }
            return buffer;
        }


        public string delete(string remoteFile)
        {
            string message = "";
            remoteFile = remoteFile.Replace(@"\", "/");
            if (remoteFile.IndexOf(".") > 0)
            {
                message = this.sendFTPcmd("DELE " + remoteFile + "\r\n");
            }
            else
            {
                message = this.sendFTPcmd("RMD " + remoteFile + "\r\n");
            }
            this.OnFTPMessageEvent(message);
            return "delete";
        }

        public string disconnect()
        {
            this.NetStrm.Close();
            return "close";
        }


        public void download(string remoteFile, string localPath)
        {
            remoteFile = remoteFile.Replace(@"\", "/");
            int length = this.revInstr(remoteFile, "/");
            string str = "/";
            string str2 = remoteFile;
            if (length != -1)
            {
                str2 = remoteFile.Substring(length + 1);
                str = remoteFile.Substring(0, length);
            }
            this.OnFTPMessageEvent("CWD " + str + "\r\n");
            string message = this.sendFTPcmd("CWD " + str + "\r\n");
            this.OnFTPMessageEvent(message);
            byte[] buffer = this.sendPassiveFTPcmd("RETR " + str2 + "\r\n");
            FileStream stream = new FileStream(localPath, FileMode.CreateNew);
            stream.Write(buffer, 0, buffer.Length);
            stream.Close();



        }

        public void docdownload(string remoteFile, string localPath)
        {
            remoteFile = remoteFile.Replace(@"\", "/");
            int length = this.revInstr(remoteFile, "/");
            string str = "/";
            string str2 = remoteFile;
            if (length != -1)
            {
                str2 = remoteFile.Substring(length + 1);
                str = remoteFile.Substring(0, length);
            }
            this.OnFTPMessageEvent("CWD " + str + "\r\n");
            string message = this.sendFTPcmd("CWD " + str + "\r\n");
            this.OnFTPMessageEvent(message);
            byte[] buffer = this.sendPassiveFTPcmd("RETR " + str2 + "\r\n");
            FileStream stream = new FileStream(localPath, FileMode.CreateNew);
            stream.Write(buffer, 0, buffer.Length);
            stream.Close();
        }
        public byte[] downloadbyte(string remoteFile)
        {
            remoteFile = remoteFile.Replace(@"\", "/");
            int length = this.revInstr(remoteFile, "/");
            string str = "/";
            string str2 = remoteFile;
            if (length != -1)
            {
                str2 = remoteFile.Substring(length + 1);
                str = remoteFile.Substring(0, length);
            }
            this.OnFTPMessageEvent("CWD " + str + "\r\n");
            string message = this.sendFTPcmd("CWD " + str + "\r\n");
            this.OnFTPMessageEvent(message);
            byte[] buffer = this.sendPassiveFTPcmd("RETR " + str2 + "\r\n");


            return buffer;
        }




        private string getHTTP(string url, string postData)
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = postData.Length;
            Stream requestStream = request.GetRequestStream();
            requestStream.Write(Encoding.ASCII.GetBytes(postData), 0, postData.Length);
            requestStream.Close();
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            StreamReader reader = new StreamReader(response.GetResponseStream());
            return reader.ReadToEnd();
        }

        public ArrayList getRemoteFolder(string path)
        {
            path = path.Replace(@"\", "/");
            string message = this.sendFTPcmd("CWD " + path + "\r\n");
            this.OnFTPMessageEvent(message);
            ArrayList list = new ArrayList();
            if (!message.StartsWith("5"))
            {
                int startIndex = 0;
                byte[] buffer = this.sendPassiveFTPcmd("LIST\r\n");
                string[] strArray = Regex.Split(Encoding.Default.GetString(buffer), "\r\n");
                for (int i = 0; i < strArray.Length; i++)
                {
                    if (strArray[i] != "")
                    {
                        if (strArray[i].StartsWith("-") || strArray[i].StartsWith("d"))
                        {
                            startIndex = 0x37;
                        }
                        else
                        {
                            startIndex = 0x27;
                        }
                        if (strArray[i].Length >= startIndex)
                        {
                            string str2 = strArray[i].Substring(startIndex);
                            if ((str2.IndexOf(".") != -1) && (str2.IndexOf("->") == -1))
                            {
                                RemoteFileOrFolder folder = new RemoteFileOrFolder();
                                folder.type = FileOrFolder.FILE;
                                folder.name = str2.Trim();
                                list.Add(folder);
                            }
                            else
                            {
                                RemoteFileOrFolder folder2 = new RemoteFileOrFolder();
                                folder2.type = FileOrFolder.FOLDER;
                                if (str2.IndexOf("->") > 0)
                                {
                                    int index = str2.IndexOf("->");
                                    str2 = str2.Substring(index + 2);
                                }
                                folder2.name = str2.Trim();
                                list.Add(folder2);
                            }
                        }
                    }
                }
            }
            return list;
        }

        protected void OnFTPMessageEvent(string message)
        {
            if (this.FTPMessageEvent != null)
            {
                this.FTPMessageEvent(message);
            }
        }



        public string rename(string remoteFile, string newName)
        {
            remoteFile = remoteFile.Replace(@"\", "/");
            this.OnFTPMessageEvent("CWD " + remoteFile + "\r\n");
            this.sendFTPcmd("CWD " + remoteFile + "\r\n");
            this.OnFTPMessageEvent("RNFR " + remoteFile + "\r\n");
            this.sendFTPcmd("RNFR " + remoteFile + "\r\n");
            this.OnFTPMessageEvent("RNTO " + newName + "\r\n");
            this.sendFTPcmd("RNTO " + newName + "\r\n");

            return "rename";
        }

        private int revInstr(string haystack, string needle)
        {
            for (int i = haystack.Length - 1; i > 0; i--)
            {
                if (haystack.Substring(i, 1) == needle)
                {
                    return i;
                }
            }
            return -1;
        }

        private string sendFTPcmd(string cmd)
        {
            this.OnFTPMessageEvent(cmd);
            StreamReader reader = new StreamReader(this.NetStrm);
            byte[] bytes = Encoding.ASCII.GetBytes(cmd.ToCharArray());
            this.NetStrm.Write(bytes, 0, bytes.Length);
            return reader.ReadLine();
        }

        private byte[] sendPassiveFTPcmd(string cmd)
        {
            this.OnFTPMessageEvent(cmd);
            ArrayList range = new ArrayList();
            byte[] buffer2 = new byte[0xff];
            int num2 = 0;
            byte[] bytes = Encoding.ASCII.GetBytes(cmd.ToCharArray());
            NetworkStream stream = this.createPassiveConnection();
            StreamReader reader = new StreamReader(this.NetStrm);
            this.NetStrm.Write(bytes, 0, bytes.Length);
            this.OnFTPMessageEvent(reader.ReadLine());
            string str = "";
            while (true)
            {
                int crop = stream.Read(buffer2, 0, buffer2.Length);
                if (crop <= 0)
                {
                    range = range.GetRange(0, num2);
                    stream.Close();
                    if (this.NetStrm.DataAvailable)
                    {
                        this.OnFTPMessageEvent(reader.ReadLine());
                    }
                    byte[] buffer3 = (byte[])range.ToArray(((byte)0).GetType());
                    this.OnFTPMessageEvent(Encoding.ASCII.GetString(buffer3));
                    return buffer3;
                }
                num2 += crop;
                range.AddRange(this.cropByteArray(buffer2, crop));
                str = str + Encoding.ASCII.GetString(buffer2);
            }
        }

        public void uploadFile(string localFile, string remotePath)
        {
            remotePath = remotePath.Replace(@"\", "/");
            this.OnFTPMessageEvent("CWD " + remotePath + "\r\n");
            this.sendFTPcmd("CWD " + remotePath + "\r\n");
            FileInfo info = new FileInfo(localFile);
            FileStream stream2 = new FileStream(localFile, FileMode.Open);
            byte[] buffer = new byte[stream2.Length];
            stream2.Read(buffer, 0, (int)stream2.Length);
            NetworkStream stream = this.createPassiveConnection();
            string cmd = "STOR " + info.Name + "\r\n";
            string message = this.sendFTPcmd(cmd);
            this.OnFTPMessageEvent(message);
            if (!message.StartsWith("5"))
            {
                stream.Write(buffer, 0, (int)stream2.Length);
                stream.Close();
                this.OnFTPMessageEvent(new StreamReader(this.NetStrm).ReadLine());
            }
            stream2.Close();
        }


        public void upload(string localFile, string remotePath)
        {
            remotePath = remotePath.Replace(@"\", "/");
            this.OnFTPMessageEvent("CWD " + remotePath + "\r\n");
            this.sendFTPcmd("CWD " + remotePath + "\r\n");
            FileInfo fileParse = new FileInfo(localFile);
            FileStream fs = new FileStream(localFile, FileMode.Open);
            byte[] fileData = new byte[(uint)fs.Length];
            fs.Read(fileData, 0, (int)fs.Length);
            NetworkStream passiveConnection = this.createPassiveConnection();
            string cmd = "STOR " + fileParse.Name + "\r\n";
            string response = this.sendFTPcmd(cmd);
            this.OnFTPMessageEvent(response);
            if (!response.StartsWith("5"))
            {
                passiveConnection.Write(fileData, 0, (int)fs.Length);
                passiveConnection.Close();
                this.OnFTPMessageEvent(new StreamReader(this.NetStrm).ReadLine());
            }
            fs.Close();
        }






        public delegate void FTPMessageDelegate(string message);
    }




}
