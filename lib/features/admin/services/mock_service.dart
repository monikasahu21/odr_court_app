import '../models/case_model.dart';

class MockService {
  static List<CaseModel> fetchCases() {
    return [
      CaseModel(
        id: 'C-1001',
        title: 'Payment dispute between A and B',
        status: 'Pending',
        createdBy: 'Claimant A',
        summary: 'Dispute about non-payment for goods delivered.',
      ),
      CaseModel(
        id: 'C-1002',
        title: 'Contract interpretation - supply terms',
        status: 'In Hearing',
        createdBy: 'Claimant B',
        summary: 'Disagreement on delivery timelines and penalties.',
      ),
    ];
  }
}
