import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_your_requests_state.dart';

class GetYourRequestsCubit extends Cubit<GetYourRequestsState> {
  GetYourRequestsCubit() : super(GetYourRequestsInitial());
}
