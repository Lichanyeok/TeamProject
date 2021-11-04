<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
   <link rel="stylesheet" href="../css/style.css">
   <link rel="stylesheet" href="../css/join_step2.css">
   <script  src="../js/jquery-3.6.0.js" ></script>
   <script type="text/javascript">
   		$(function(){
   			$('#agree1').on('change',function(){
//    				alert('gd');
				if($('#agree1').prop('checked')){
// 					alert('����');
					$('#agree2').prop('checked',true);
					$('#agree3').prop('checked',true);
				}
				if(!$('#agree1').prop('checked')){
					$('#agree2').prop('checked',false);
					$('#agree3').prop('checked',false);
				}
   			});
   			
   			$('#btnGo').on('click',function(){
   				if($('#agree2').prop('checked')&&$('#agree3').prop('checked')){
   					location.href='./memberJoin.jsp';
   				}else{
   					alert('��� ���� �ʼ�!');
   				}
   			});
   		});
   </script>
</head>
<body>

    <div class = "join_container">
            <h1><a href="../"><img alt="" src="../images/LOGO.png"></a></h1>
            <ul class="ingo_top">
                <li class ="active">STEP1.�������</li>
                <li>STEP2.�����Է�</li>
                <li>STEP3.���ԿϷ�</li>
            </ul>   
        </div>
        <section class = "agree">
            <h1>������� �� ����Ȱ�뵿��</h1>
            <p>ȸ�������� �Է����ּ���</p>
            <div class = "agree_line">
            <input type="checkbox" id="agree1"><label class = "agree_font"for="agree1">�ʼ��׸� ��ü����</label>
            </div>
            <ul class = "agree_box">
               <li>
                <input type="checkbox" id="agree2"><label for="agree2">�������� �̿� ��� ����(�ʼ�)</label>
                <div class = "box1">
                    <p>��1��(����) <br>
                    	�� (��)���� (���� ��ȸ�硯�� �Ѵ�)�� ������Ÿ� �̿����� �� ������ȣ � ���� ����, ����������ȣ�� �� ���� ����(���� ������ ���ɡ� �̶� ��)�� ���� �̿����� ���������� ��ȣ�ϰ�, �̿� ������ ������ �ż��ϰ� ��Ȱ�ϰ� ó���� �� �ֵ��� �ϱ� ���Ͽ� ������ ���� ��������ó����ħ�� �����մϴ�.

						��������ó����ħ�� �̿��ڰ� ������ ���� ������ �� �ֵ��� ���� �ʱ�ȭ���� ���� �����ϰ� ������, �������� ���ù���, ��ħ, ��� �Ǵ� ȸ�� ��å�� ���濡 ���� ����� �� �ֽ��ϴ�.<br>
						<br>
                        �� ���������� ��3�� ����
						ȸ��� �̿����� ���������� �������� �������̿� �������� ����� ���� ������ ����ϸ�, ��Ģ������ �̿����� ���� ���� ���� �������� �������̿� ���� ������ �ʰ��Ͽ� �̿��ϰų� �̿����� ���������� �������� �ʽ��ϴ�.<br>
							 
                    </p>
                </div>
               </li> 
               <li>
                <input type="checkbox" id="agree3"><label for="agree3">���� �̿� ��� ����(�ʼ�)</label>
                <div class = "box1">
                    <p>��1��(����) <br>
                        �� ����� ������ ó�� ��� ȸ��(���ڻ�ŷ� �����)�� ��ϴ� OO ���̹� ��(���� �������̶� �Ѵ�)���� �����ϴ� ���ͳ� ���� ����(���� �����񽺡��� �Ѵ�)�� �̿��Կ� �־� ���̹� ���� �̿����� �Ǹ�?�ǹ� �� å�ӻ����� �������� �������� �մϴ�.<br>
                        
                        �ء�PC���, ���� ���� �̿��ϴ� ���ڻ�ŷ��� ���ؼ��� �� ������ ������ �ʴ� �� �� ����� �ؿ��մϴ١�<br>
                        
                        ��2��(����) <br>
                        �硰���� �̶� OO ȸ�簡 ��ȭ �Ǵ� �뿪(���� ����ȭ��̶� ��)�� �̿��ڿ��� �����ϱ� ���Ͽ� ��ǻ�͵� ������ż��� �̿��Ͽ� ��ȭ���� �ŷ��� �� �ֵ��� ������ ������ �������� ���ϸ�, �ƿ﷯ ���̹����� ��ϴ� ������� �ǹ̷ε� ����մϴ�.
                        
                    </p>
                </div>
               </li> 
            </ul>
            
            <button id="btnGo">Ȯ��</button>

        </section>
        
    </body>
</html>