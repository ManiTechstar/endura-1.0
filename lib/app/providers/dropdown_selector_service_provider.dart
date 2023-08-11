import 'dart:convert';

import 'package:endura_app/app/data/model/account_representative_list_model.dart';
import 'package:endura_app/app/data/model/analysis_form_customer_list_model.dart';
import 'package:endura_app/app/data/model/customer_list_model.dart';
import 'package:endura_app/app/data/model/leases_model.dart';
import 'package:endura_app/app/data/model/route_list_model.dart';
import 'package:endura_app/app/data/model/service_tech_home_lease_model.dart';
import 'package:endura_app/app/data/model/warehouse_model.dart';
import 'package:endura_app/core/base/services/base_http_client.dart';

class DropdownSelectorServiceProvider extends BaseHttpClient {
  Future<RouteListModel> getAllRoutes() async {
    final response = await get('/routes/get_task_routes');
    final responseBody = jsonDecode(response.body);
    RouteListModel model = RouteListModel.fromJson(responseBody);
    print(model.routes);
    return model;
  }

  Future<WarehoseModel> getAllWarehouses() async {
    final response = await get('/warehouse/get_warehouse');
    final responseBody = jsonDecode(response.body);
    WarehoseModel model = WarehoseModel.fromJson(responseBody);
    print(model.result!.length);
    return model;
  }

  Future<CustomerListModel> getAllCompaniesOrCustomers() async {
    final response = await get('/customer/get_customers?page=1&limit=10000');
    final responseBody = jsonDecode(response.body);
    CustomerListModel model = CustomerListModel.fromJson(responseBody);
    print(model.result!.length);
    return model;
  }

  Future<AnalysisFormCustomerListModel> getCompaniesOrCustomersByRepresentative(
      {id}) async {
    final response = await post(
        '/well_customer/get_customers_by_accountManagers',
        body: {'account_rep_id': id});
    final responseBody = jsonDecode(response.body);
    AnalysisFormCustomerListModel model =
        AnalysisFormCustomerListModel.fromJson(responseBody);
    print(model.result!.length);
    return model;
  }

  Future<LeasesModel> getAllLocationsByCustomerId({customerId}) async {
    final response = await post('/service_report/get_location_by_customer_id',
        body: {'customer_id': customerId});
    final responseBody = jsonDecode(response.body);
    LeasesModel model = LeasesModel.fromJson(responseBody);
    print(model.result!.length);
    return model;
  }

  Future<ServiceTechHomeLeaseModel> getAllWellsByCustomer(
      {email, accRepEmail, customerId}) async {
    final response = await get(
      '/well_customer/getServiceWells?service_tech_email=$email&account_manager_email=$accRepEmail&company_id=$customerId',
    );
    final responseBody = jsonDecode(response.body);
    ServiceTechHomeLeaseModel model =
        ServiceTechHomeLeaseModel.fromJson(responseBody);
    print(model.result!.length);
    return model;
  }

  Future<AccountRepresentativeListModel> getAllRepresentatives(
      {customerId}) async {
    final response =
        await post('/user/get_user_by_role', body: {"role": "Account Manager"});
    final responseBody = jsonDecode(response.body);
    AccountRepresentativeListModel model =
        AccountRepresentativeListModel.fromJson(responseBody);
    print(model.result!.length);
    return model;
  }

  Future<AccountRepresentativeListModel> getAllAccountRepresentativesOrManagers(
      {email}) async {
    final response =
        await get('/well_customer/getServiceAccountManagers?user_email=$email');
    final responseBody = jsonDecode(response.body);
    AccountRepresentativeListModel model =
        AccountRepresentativeListModel.fromJson(responseBody);
    print(model.result!.length);
    return model;
  }

  Future<CustomerListModel> getAllCompaniesAccountRepresentatives(
      {email, accRepEmail}) async {
    final response = await get(
        '/well_customer/getServiceCompanies?service_tech_email=$email&account_manager_email=$accRepEmail');
    final responseBody = jsonDecode(response.body);
    CustomerListModel model = CustomerListModel.fromJson(responseBody);
    print(model.result!.length);
    return model;
  }
}
