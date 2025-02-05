import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivateInfoPage extends StatelessWidget {
  const PrivateInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('개인정보 수집·이용'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Column(
            children: [
              Text("1. 수집하는 개인정보 항목\n"
                  "'MuOz'는 아래의 경우에 한하여 최소한의 개인정보를 수집합니다.\n"
                  " - 구글 로그인 시: 이메일 주소\n"
                  "카카오 및 애플 로그인을 이용하는 경우, 별도의 개인정보를 수집하지 않습니다.\n\n"
                  "2. 개인정보의 이용 목적\n"
                  "수집된 이메일 주소는 다음의 목적으로 사용됩니다.\n"
                  " - 사용자 계정 식별 및 로그인 관리\n"
                  " - 서비스 운영 및 고객 지원 제공\n\n"
                  "또한, 'MuOz'는 Gemini AI를 활용하여 사용자의 취향을 분석하고 이에 맞는 음악을 추천하는 기능을 제공합니다. 이 과정에서 사용자의 개별적인 취향 데이터가 AI 모델 학습에 활용될 수 있지만, 이를 통해 사용자를 직접 식별할 수 있는 정보는 포함되지 않습니다.\n\n"
                  "3. 개인정보 보관 및 파기\n"
                  " - 사용자가 'MuOz'계정을 삭제하는 경우, 수집된 개인정보는 즉시 파기 됩니다.\n"
                  " - 관련 법령에 따라 일정 기간 보관이 필요한 경우 해당 기간 동안 안전하게 저장된 후 삭제됩니다.\n\n"
                  "4. 제3자 제공 및 위탁 여부"
                  "'MuOz'는 사용자의 개인정보를 제3자에게 제공하거나 외부에 위탁하지 않습니다. 다만, 법령에 의해 요구되는 경우에는 예외적으로 제공될 수 있습니다.\n\n"
                  "5. 이용자의 권리\n"
                  " - 사용자는 언제든지 개인정보 제공에 대한 동의를 철회할 수 있으며, 계정 삭제를 요청할 수 있습니다.\n"
                  " - 개인정보 관련 문의는 고객지원 이메일을 통해 가능합니다.\n\n"
                  "6. 변경 사항 안내\n"
                  "본 개인정보 수집 및 이용 정책은 변경될 수 있으며, 중요한 변경 사항이 있을 경우 사전 공지합니다.\n\n"),
              TextButton(
                onPressed: () {
                  launchUrl(Uri.parse("https://policies.google.com/privacy"));
                },
                child: Text(
                  '구글 정책으로 바로가기',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
