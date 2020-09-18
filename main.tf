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

locals {
  roles = var.privileges.roles != null ? var.privileges.roles : []
  users = var.privileges.users != null ? var.privileges.users : []

  rolePermissions = flatten([
    for role in local.roles: [
      for permission in try(role.permissions, []):
      merge(permission, {
        role = role.name
      })
    ]
  ])

  userPermissions = flatten([
    for user in local.users: [
      for permission in try(user.permissions, []):
      merge(permission, {
        user = user.name
      })
    ]
  ])
}
