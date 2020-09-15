/**
 * Copyright 2020 Taito United
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "mysql_grant" "role_permission" {
  depends_on  = [ mysql_role.role ]
  count       = length(local.rolePermissions)
  database    = local.rolePermissions[count.index].database
  role        = local.rolePermissions[count.index].role
  privileges  = local.rolePermissions[count.index].privileges
}

resource "mysql_grant" "user_permission" {
  depends_on  = [ mysql_user.user ]
  count       = length(local.userPermissions)
  database    = local.userPermissions[count.index].database
  user        = local.userPermissions[count.index].user
  privileges  = local.userPermissions[count.index].privileges
  roles       = local.userPermissions[count.index].roles
}
