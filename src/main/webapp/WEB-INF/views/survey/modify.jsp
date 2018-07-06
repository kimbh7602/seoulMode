<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Insert <small>Some examples to get you started</small></h3>
              </div>

<!--               <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div> -->
            </div> 

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Survey Board <small>Users</small></h2>
                    
                    <!--  Board right-top -->
<!--                     <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul> -->
                    <!-- End of Board right-top -->
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <p class="text-muted font-13 m-b-30">
                    	설문조사의 제목, 질문, 보기를 직접 작성한 후 등록 버튼을 눌러주세요.
                    </p>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                <!-- enctype을 설정해주면 Resolver에서 인지함. -->
                                    <form role="form" enctype="multipart/form-data" method="POST" action="<c:url value='/member/merge' />">
	                                    <input type="hidden" name="forwardView" value="/member/read" />
	                                    <input type="hidden" name="MEMBER_SEQ" value="${resultMap.MEMBER_SEQ }" />
	                                    <input type="hidden" name="ORGANIZATION_SEQ" value="UUID-11-CIPI9M" />
	                                    <input type="hidden" name="AUTHORITY_ID" value="dummy_id" />
                                        <div class="form-group">
                                            <label>MEMBER_ID Text Input </label>
                                            <input class="form-control" type="text" name="MEMBER_ID" value="${resultMap.MEMBER_ID }">
                                        </div>
                                        <div class="form-group">
                                            <label>Member PASSWORD Text Input </label>
                                            <input class="form-control" type="password" name="PASSWORD" value="${resultMap.PASSWORD }">
                                        </div>
                                        <div class="form-group">
                                            <label>Member Name Text Input </label>
                                            <input class="form-control" type="text" name="NAME" value="${resultMap.NAME }">
                                        </div>
                                        <div class="form-group">
                                            <label>EMAIL Text Input with Placeholder </label>
                                            <input class="form-control" type="text" name="EMAIL" placeholder="incubator@clustringincubation.com" value="${resultMap.EMAIL }">
                                            <p class="help-block">Base form incubator@clustringincubation.com</p>
                                        </div>
                                        <div class="form-group">
                                            <label>CELLPHONE Text Input with Placeholder </label>
                                            <input class="form-control" type="text" name="CELLPHONE" placeholder="000-0000-0000" value="${resultMap.CELLPHONE }">
                                            <p class="help-block">Base form 000-0000-0000</p>
                                        </div>
                                        <div class="form-group">
                                            <hr>
                                            <input type="file" name="ATTACHEDFILES"/>
                                            <input type="file" name="ATTACHEDFILES02" />
                                        </div>
                                        <button type="submit" class="btn btn-default">${paramMap.action == 'update' ? 'Update' : 'Insert' } Button</button>
                                        <button type="reset" class="btn btn-default">Reset Button</button>
                                    </form>
                                </div>
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /.panel-body -->
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->